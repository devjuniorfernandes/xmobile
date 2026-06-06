import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_skeleton.dart';
import 'task_card.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: () => _showAdvancedFilters(context, state, controller),
            icon: Icon(
              state.hasFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
          ),
        ],
      ),
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
                  onSelected: (_) => controller.clearFilters(),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Pendente'),
                  selected: state.status == 'pendente',
                  onSelected: (_) => controller.setStatus('pendente'),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Concluída'),
                  selected: state.status == 'concluida',
                  onSelected: (_) => controller.setStatus('concluida'),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Alta'),
                  selected: state.prioridade == 'alta',
                  onSelected: (_) => controller.setPrioridade(
                    state.prioridade == 'alta' ? null : 'alta',
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
                      itemCount:
                          state.items.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        if (index >= state.items.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final task = state.items[index];
                        return TaskCard(
                          task: task,
                          onTap: () =>
                              context.push('/tasks/detail', extra: task),
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
  ) {
    final departamento = TextEditingController(text: state.departamento);
    final projeto = TextEditingController(text: state.projeto);
    final responsavel = TextEditingController(text: state.responsavel);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filtros',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: departamento,
              decoration: const InputDecoration(
                labelText: 'Departamento',
                prefixIcon: Icon(Icons.account_tree_outlined),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: projeto,
              decoration: const InputDecoration(
                labelText: 'Projeto',
                prefixIcon: Icon(Icons.folder_copy_outlined),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: responsavel,
              decoration: const InputDecoration(
                labelText: 'Responsável',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                controller.applyAdvancedFilters(
                  departamento: departamento.text.trim(),
                  projeto: projeto.text.trim(),
                  responsavel: responsavel.text.trim(),
                );
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  GoRouter.of(context).go('/');
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('Aplicar filtros'),
            ),
          ],
        ),
      ),
    );
  }
}
