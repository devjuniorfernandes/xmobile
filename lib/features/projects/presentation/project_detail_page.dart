import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/metric_card.dart';
import '../../../data/models/project_model.dart';
import '../../auth/auth_controller.dart';
import '../../tasks/presentation/task_card.dart';
import 'project_form_sheet.dart';
import 'project_tasks_provider.dart';
import 'projects_controller.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  const ProjectDetailPage({super.key, required this.project});

  final Project project;

  @override
  ConsumerState<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends ConsumerState<ProjectDetailPage> {
  late Project _project;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    final metrics = _project.metricas;
    final tasks = ref.watch(
      projectTasksProvider((
        projectId: _project.id,
        projectName: _project.nome,
      )),
    );

    final auth = ref.watch(authControllerProvider);
    final userRole = auth.user?.usuario?.cargo?.nome.toLowerCase() ?? '';
    final isAdmin = auth.user?.isAdmin ?? false;
    final isCoordenador = userRole.contains('coordenad') || isAdmin;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.ink,
            child: const BackButton(),
          ),
        ),
        actions: [
          if (isCoordenador)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.ink,
                child: IconButton(
                  onPressed: _saving ? null : _handleDelete,
                  icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.ink,
              child: IconButton(
                onPressed: _saving ? null : _showEditSheet,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.ink,
                          ),
                        ),
                      )
                    : const Icon(Icons.edit_outlined),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Premium Orange Gradient Header
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 56,
              20,
              32,
            ),
            decoration: const BoxDecoration(
              gradient: AppColors.brandGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _project.nome,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _project.statusProjeto ?? 'Sem status',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Quick info chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _HeaderInfoChip(
                        icon: Icons.business,
                        label: _project.empresa?.nome ?? 'Não informada',
                      ),
                      const SizedBox(width: 8),
                      _HeaderInfoChip(
                        icon: Icons.person_outline,
                        label: _project.responsavel?.nome ?? 'Não atribuído',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Mover o InfoCard para ficar abaixo dos chips do header
                // _InfoCard foi movido para o header para melhor agrupamento visual
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DESCRIÇÃO DO PROJECTO',
                  style: GoogleFonts.roboto(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  _project.descricao ?? 'Sem descrição.',
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoCard(
                  rows: {
                    'Início': _date(_project.dataInicio),
                    'Prazo': _date(_project.dataPrazo),
                    'Fim': _date(_project.dataFim),
                  },
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.95,
                  children: [
                    MetricCard(
                      title: 'Total',
                      value: '${metrics?.tarefasTotal ?? 0}',
                      icon: Icons.format_list_bulleted,
                      color: AppColors.pantone2955C,
                    ),
                    MetricCard(
                      title: 'Concluídas',
                      value: '${metrics?.tarefasConcluidas ?? 0}',
                      icon: Icons.check_circle_outline,
                      color: AppColors.success,
                    ),
                    MetricCard(
                      title: 'Atraso',
                      value: '${metrics?.tarefasEmAtraso ?? 0}',
                      icon: Icons.warning_amber,
                      color: AppColors.danger,
                    ),
                  ],
                ),
                if (_project.referencias != null && _project.referencias!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Referências do Projeto',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  ..._project.referencias!.map(
                    (refItem) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          refItem.tipo.toLowerCase() == 'link'
                              ? Icons.link
                              : Icons.description_outlined,
                          color: AppColors.pantone2955C,
                        ),
                        title: Text(refItem.titulo),
                        subtitle: refItem.descricao != null
                            ? Text(refItem.descricao!)
                            : null,
                        trailing: const Icon(Icons.open_in_new, size: 18),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Abrir URL: ${refItem.url}')),
                          );
                        },
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  'Tarefas Relacionadas',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                tasks.when(
                  loading: () => const Card(
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (error, _) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        'Não foi possível carregar as tarefas relacionadas.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                  data: (items) => items.isEmpty
                      ? Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text(
                              'Nenhuma tarefa relacionada encontrada.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      : Column(
                          children: items
                              .map(
                                (task) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: TaskCard(
                                    task: task,
                                    onTap: () => context.push(
                                      '/tasks/detail',
                                      extra: task,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _date(String? value) {
    if (value == null || value.isEmpty) return 'Não informada';
    final parsed = DateTime.tryParse(value);
    return parsed == null ? value : DateFormat('dd/MM/yyyy').format(parsed);
  }

  Future<void> _showEditSheet() async {
    final authState = ref.read(authControllerProvider);
    final userRole = authState.user?.usuario?.cargo?.nome.toLowerCase() ?? '';
    final isAdmin = authState.user?.isAdmin ?? false;
    final isCoordenador = userRole.contains('coordenad') || isAdmin;

    if (!isCoordenador) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Edição de projeto via API não permitida para Gestores. Requer aprovação no painel web.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => ProjectFormSheet(project: _project),
    );

    if (result == true) {
      final projectsState = ref.read(projectsControllerProvider);
      final updated = projectsState.items.firstWhere(
        (p) => p.id == _project.id,
        orElse: () => _project,
      );
      setState(() {
        _project = updated;
      });
    }
  }

  Future<void> _handleDelete() async {
    final hasTasks = _project.metricas != null && _project.metricas!.tarefasTotal > 0;
    if (hasTasks) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Finalize ou cancele o projeto para preservar o histórico.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Projeto'),
        content: const Text('Tem a certeza que deseja eliminar este projeto? Esta ação é irreversível.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _saving = true);
      try {
        await ref.read(projectsControllerProvider.notifier).deleteProject(_project.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Projeto eliminado com sucesso.')),
          );
          context.pop();
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      } finally {
        if (mounted) setState(() => _saving = false);
      }
    }
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  final Map<String, String> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: rows.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(entry.value, textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _HeaderInfoChip extends StatelessWidget {
  const _HeaderInfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
