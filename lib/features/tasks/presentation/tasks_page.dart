import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../data/models/user_model.dart';
import '../../auth/auth_controller.dart';
import '../../projects/presentation/projects_controller.dart';
import '../../shared/metadata_controller.dart';
import 'task_card.dart';
import 'task_form_sheet.dart';
import 'tasks_controller.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 320) {
        ref.read(tasksControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tasksControllerProvider);
    final controller = ref.read(tasksControllerProvider.notifier);
    final metadataState = ref.watch(metadataControllerProvider);
    final authState = ref.watch(authControllerProvider);

    // Resolve IDs dynamically from metadata list names
    final pendenteMatch = metadataState.statusTarefas.firstWhere(
      (s) => s.nome.contains('PRODUZIR') || s.nome.contains('ANDAMENTO'),
      orElse: () => const NamedEntity(id: 1, nome: ''),
    );
    final pendenteId = pendenteMatch.id;

    final concluidaMatch = metadataState.statusTarefas.firstWhere(
      (s) => s.nome.contains('CONCLU'),
      orElse: () => const NamedEntity(id: 4, nome: ''),
    );
    final concluidaId = concluidaMatch.id;

    final altaMatch = metadataState.prioridades.firstWhere(
      (p) => p.nome.toLowerCase().contains('alt'),
      orElse: () => const NamedEntity(id: 1, nome: ''),
    );
    final altaId = altaMatch.id;

    // RBAC: check permissions
    final userRole = authState.user?.usuario?.cargo?.nome.toLowerCase() ?? '';
    final isAdmin = authState.user?.isAdmin ?? false;
    final canCreate = userRole.contains('coordenad') || userRole.contains('gestor') || isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: () => _showAdvancedFilters(context, state, controller, ref),
            icon: Icon(
              state.hasFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
      floatingActionButton: canCreate
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  builder: (context) => const TaskFormSheet(),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
            child: TextField(
              onChanged: controller.search,
              decoration: const InputDecoration(
                hintText: 'Pesquisar tarefas',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                FilterChip(
                  label: const Text('Todas'),
                  selected: !state.hasFilters,
                  onSelected: (selected) => controller.clearFilters(),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Pendente'),
                  selected: state.statusId == pendenteId,
                  onSelected: (selected) => controller.setStatusId(
                    state.statusId == pendenteId ? null : pendenteId,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Concluída'),
                  selected: state.statusId == concluidaId,
                  onSelected: (selected) => controller.setStatusId(
                    state.statusId == concluidaId ? null : concluidaId,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Alta'),
                  selected: state.prioridadeId == altaId,
                  onSelected: (selected) => controller.setPrioridadeId(
                    state.prioridadeId == altaId ? null : altaId,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: state.isLoading
                ? const AppSkeleton()
                : state.error != null && state.items.isEmpty
                    ? AppErrorState(
                        message: state.error!,
                        onRetry: controller.refresh,
                      )
                    : state.items.isEmpty
                        ? const AppEmptyState(
                            title: 'Sem tarefas',
                            message: 'Nenhuma tarefa encontrada.',
                          )
                        : RefreshIndicator(
                            onRefresh: controller.refresh,
                            child: ListView.separated(
                              controller: _scrollController,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                              itemCount: state.items.length +
                                  (state.isLoadingMore ? 1 : 0),
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                if (index >= state.items.length) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                  final task = state.items[index];
                                  return TaskCard(
                                    task: task,
                                    onTap: () => context.push('/tasks/detail',
                                        extra: task),
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      );
    }

  void _showAdvancedFilters(
    BuildContext context,
    TasksState state,
    TasksController controller,
    WidgetRef ref,
  ) {
    final metadataState = ref.read(metadataControllerProvider);
    final projectsState = ref.read(projectsControllerProvider);

    int? selectedDeptId = state.departamentoId;
    int? selectedProjId = state.projetoId;
    int? selectedRespId = state.responsavelId;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Filtros Avançados',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),

              // Project dropdown
              DropdownButtonFormField<int>(
                initialValue: selectedProjId,
                decoration: const InputDecoration(
                  labelText: 'Projeto',
                  prefixIcon: Icon(Icons.folder_copy_outlined),
                ),
                items: [
                  const DropdownMenuItem(
                      value: null, child: Text('Todos os projetos')),
                  ...projectsState.items.map((p) => DropdownMenuItem(
                        value: p.id,
                        child: Text(p.nome),
                      ))
                ],
                onChanged: (val) => setState(() => selectedProjId = val),
              ),
              const SizedBox(height: 12),

              // Department dropdown
              DropdownButtonFormField<int>(
                initialValue: selectedDeptId,
                decoration: const InputDecoration(
                  labelText: 'Departamento',
                  prefixIcon: Icon(Icons.account_tree_outlined),
                ),
                items: [
                  const DropdownMenuItem(
                      value: null, child: Text('Todos os departamentos')),
                  ...metadataState.departamentos.map((d) => DropdownMenuItem(
                        value: d.id,
                        child: Text(d.nome),
                      ))
                ],
                onChanged: (val) => setState(() => selectedDeptId = val),
              ),
              const SizedBox(height: 12),

              // Responsible dropdown
              DropdownButtonFormField<int>(
                initialValue: selectedRespId,
                decoration: const InputDecoration(
                  labelText: 'Responsável',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                items: [
                  const DropdownMenuItem(
                      value: null, child: Text('Todos os responsáveis')),
                  ...metadataState.usuarios.map((u) => DropdownMenuItem<int>(
                        value: (u['id'] as num).toInt(),
                        child: Text(u['nome'].toString()),
                      ))
                ],
                onChanged: (val) => setState(() => selectedRespId = val),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.clearFilters();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Limpar Filtros'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        controller.applyAdvancedFilters(
                          departamentoId: selectedDeptId,
                          projetoId: selectedProjId,
                          responsavelId: selectedRespId,
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aplicar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
