import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/task_model.dart';
import 'tasks_controller.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  const TaskDetailPage({super.key, required this.task});

  final TaskItem task;

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  late TaskItem _task;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
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
          // Large Brand Gradient Header (matches Figma mock)
          Container(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 56,
              20,
              32,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.pantone2955C, Color(0xFF1E3A8A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _task.titulo,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),

                // Task Icons Row & Priority Pill
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
                      color: Colors.white70,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '3 Sub-itens',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    if (_task.prioridade != null) ...[
                      Text(
                        'Prioridade  ',
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityBgColor(_task.prioridade),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _task.prioridade!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                // Divider Line
                Container(height: 1, color: Colors.white24),
                const SizedBox(height: 16),
                // Assigned To & Due Date Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atribuído a',
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white24,
                                child: Text(
                                  _task.responsavel?.nome.isNotEmpty ?? false
                                      ? _task.responsavel!.nome
                                            .substring(0, 1)
                                            .toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _task.responsavel?.nome ?? 'Não atribuído',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 36, color: Colors.white24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prazo de entrega',
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _date(_task.dataPrazo),
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  'DESCRIÇÃO DA TAREFA',
                  style: GoogleFonts.roboto(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  _task.descricao ?? 'Sem descrição da tarefa.',
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sub Task list (custom presentations of task details)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalhes da Tarefa',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 14),
                // Card 1: Project
                _SubTaskItemCard(
                  title: 'Projeto',
                  subtitle: _task.projeto?.nome ?? 'Sem projeto associado',
                  isCompleted: _task.projeto != null,
                  avatarInitials: _task.projeto?.nome
                      .substring(0, 1)
                      .toUpperCase(),
                ),
                // Card 2: Department
                _SubTaskItemCard(
                  title: 'Departamento',
                  subtitle:
                      _task.departamento?.nome ?? 'Sem departamento associado',
                  isCompleted: _task.departamento != null,
                  avatarInitials: _task.departamento?.nome
                      .substring(0, 1)
                      .toUpperCase(),
                ),
                // Card 3: Completion Date
                _SubTaskItemCard(
                  title: 'Data de Conclusão',
                  subtitle: _task.dataConclusao != null
                      ? _date(_task.dataConclusao)
                      : 'Pendente de conclusão',
                  isCompleted: _task.dataConclusao != null,
                  iconData: Icons.check_circle_outline,
                ),
                if (_task.entregueAtrasado) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.danger.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.danger,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Atenção: Esta tarefa foi entregue fora do prazo estipulado.',
                            style: TextStyle(
                              color: AppColors.danger,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityBgColor(String? priority) {
    if (priority == null) return Colors.white24;
    final lower = priority.toLowerCase();
    if (lower.contains('alt') || lower.contains('urg')) return AppColors.danger;
    if (lower.contains('med')) return AppColors.pantone1505C;
    return AppColors.success;
  }

  String _date(String? value) {
    if (value == null || value.isEmpty) return 'Sem data';
    final parsed = DateTime.tryParse(value);
    return parsed == null ? value : DateFormat('dd/MM/yyyy').format(parsed);
  }

  Future<void> _showEditSheet() async {
    final statusController = TextEditingController(text: _task.status ?? '');
    final responsibleController = TextEditingController(
      text: _task.responsavel?.id == 0
          ? ''
          : _task.responsavel?.id.toString() ?? '',
    );
    final people = _responsibleOptions();
    const statuses = ['PENDENTE', 'ANDAMENTO', 'CONCLUIDA', 'CANCELADA'];

    await showModalBottomSheet<void>(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Editar tarefa',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            DropdownMenu<String>(
              controller: statusController,
              width: double.infinity,
              label: const Text('Estado'),
              dropdownMenuEntries: statuses
                  .map(
                    (status) => DropdownMenuEntry(value: status, label: status),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            if (people.isEmpty)
              TextField(
                controller: responsibleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID do responsável',
                  prefixIcon: Icon(Icons.person_add_alt_outlined),
                ),
              )
            else
              DropdownMenu<int>(
                width: double.infinity,
                label: const Text('Responsável'),
                initialSelection: int.tryParse(responsibleController.text),
                onSelected: (value) =>
                    responsibleController.text = value?.toString() ?? '',
                dropdownMenuEntries: people.entries
                    .map(
                      (entry) => DropdownMenuEntry(
                        value: entry.key,
                        label: entry.value,
                      ),
                    )
                    .toList(),
              ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();
                await _saveTask(
                  statusController.text.trim(),
                  int.tryParse(responsibleController.text.trim()),
                );
              },
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar alterações'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask(String status, int? responsavelId) async {
    setState(() => _saving = true);
    try {
      final updated = await ref
          .read(tasksControllerProvider.notifier)
          .updateTask(
            id: _task.id,
            status: status,
            responsavelId: responsavelId,
          );
      setState(() => _task = updated);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa atualizada com sucesso.')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Map<int, String> _responsibleOptions() {
    final options = <int, String>{};
    final current = _task.responsavel;
    if (current != null && current.id > 0) {
      options[current.id] = current.nome;
    }
    for (final task in ref.read(tasksControllerProvider).items) {
      final responsible = task.responsavel;
      if (responsible != null && responsible.id > 0) {
        options[responsible.id] = responsible.nome;
      }
    }
    return options;
  }
}

class _SubTaskItemCard extends StatelessWidget {
  const _SubTaskItemCard({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.avatarInitials,
    this.iconData,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
  final String? avatarInitials;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Leading element (Avatar or Icon)
          if (avatarInitials != null)
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.pantone2955C.withOpacity(0.1),
              foregroundColor: AppColors.pantone2955C,
              child: Text(
                avatarInitials!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            )
          else if (iconData != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.pantone1505C.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: AppColors.pantone1505C, size: 18),
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.muted.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.assignment_outlined,
                color: AppColors.muted,
                size: 18,
              ),
            ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: AppColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          // Trailing status indicator
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted
                    ? AppColors.success
                    : AppColors.muted.withOpacity(0.3),
                width: 2,
              ),
              color: isCompleted ? AppColors.success : Colors.transparent,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
        ],
      ),
    );
  }
}
