import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/network/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/project_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../auth/auth_controller.dart';
import '../../projects/presentation/projects_controller.dart';
import '../../shared/metadata_controller.dart';
import 'tasks_controller.dart';

class TaskFormSheet extends ConsumerStatefulWidget {
  const TaskFormSheet({super.key, this.task, this.initialProject});

  final TaskItem? task;
  final Project? initialProject;

  @override
  ConsumerState<TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends ConsumerState<TaskFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  int? _selectedProjectId;
  int? _selectedDeptId;
  int? _selectedPriorityId;
  int? _selectedResponsibleId;
  int? _selectedStatusId;

  DateTime? _dueDate;
  DateTime? _completionDate;

  bool _isSaving = false;
  Map<String, List<String>> _fieldErrors = {};

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    _titleController = TextEditingController(text: t?.titulo ?? '');
    _descriptionController = TextEditingController(text: t?.descricao ?? '');

    _selectedProjectId = t?.projeto?.id ?? widget.initialProject?.id;
    _selectedDeptId = t?.departamento?.id;
    _selectedPriorityId = t?.prioridade != null
        ? _findPriorityIdByName(t!.prioridade!.nome)
        : null;
    _selectedResponsibleId = t?.responsavel?.id == 0
        ? null
        : t?.responsavel?.id;
    _selectedStatusId = t?.status?.id;

    if (t?.dataPrazo != null) {
      _dueDate = DateTime.tryParse(t!.dataPrazo!);
    }
    if (t?.dataConclusao != null) {
      _completionDate = DateTime.tryParse(t!.dataConclusao!);
    }
  }

  int? _findPriorityIdByName(String name) {
    // Try to resolve priority ID from metadata
    final metadataState = ref.read(metadataControllerProvider);
    final match = metadataState.prioridades.firstWhere(
      (p) => p.nome.toLowerCase() == name.toLowerCase(),
      orElse: () => const NamedEntity(id: -1, nome: ''),
    );
    return match.id == -1 ? null : match.id;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDueDate) async {
    final initialDate = isDueDate
        ? (_dueDate ?? DateTime.now())
        : (_completionDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.pantone2955C,
              onPrimary: Colors.white,
              onSurface: AppColors.ink,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isDueDate) {
          _dueDate = picked;
        } else {
          _completionDate = picked;
        }
      });
    }
  }

  Project? _getSelectedProject() {
    if (_selectedProjectId == null) return null;
    final projectsState = ref.read(projectsControllerProvider);
    final match = projectsState.items.firstWhere(
      (p) => p.id == _selectedProjectId,
      orElse: () => const Project(id: -1, nome: ''),
    );
    return match.id == -1 ? null : match;
  }

  Future<void> _submit() async {
    setState(() {
      _fieldErrors = {};
    });

    if (!_formKey.currentState!.validate()) return;

    if (_selectedDeptId == null) {
      setState(() {
        _fieldErrors['departamento_id'] = ['Selecione o departamento.'];
      });
      return;
    }

    if (_selectedPriorityId == null) {
      setState(() {
        _fieldErrors['prioridade_id'] = ['Selecione a prioridade.'];
      });
      return;
    }

    // Business Rule Validation: Task deadline cannot be after project deadline
    final project = _getSelectedProject();
    if (project != null && project.dataPrazo != null && _dueDate != null) {
      final projectDue = DateTime.tryParse(project.dataPrazo!);
      if (projectDue != null && _dueDate!.isAfter(projectDue)) {
        setState(() {
          _fieldErrors['data_prazo'] = [
            'O prazo da tarefa (${DateFormat('dd/MM/yyyy').format(_dueDate!)}) '
                'não pode ser posterior ao prazo do projeto (${DateFormat('dd/MM/yyyy').format(projectDue)}).',
          ];
        });
        return;
      }
    }

    setState(() => _isSaving = true);

    try {
      final formatter = DateFormat('yyyy-MM-dd');
      final dueStr = _dueDate != null ? formatter.format(_dueDate!) : null;
      final completionStr = _completionDate != null
          ? formatter.format(_completionDate!)
          : null;

      final isEdit = widget.task != null;

      if (isEdit) {
        await ref
            .read(tasksControllerProvider.notifier)
            .updateTask(
              id: widget.task!.id,
              titulo: _titleController.text.trim(),
              descricao: _descriptionController.text.trim(),
              departamentoId: _selectedDeptId!,
              prioridadeId: _selectedPriorityId!,
              projetoId: _selectedProjectId,
              usuarioId: _selectedResponsibleId,
              statusId: _selectedStatusId,
              dataPrazo: dueStr,
              dataConclusao: completionStr,
            );
      } else {
        await ref
            .read(tasksControllerProvider.notifier)
            .createTask(
              titulo: _titleController.text.trim(),
              descricao: _descriptionController.text.trim(),
              departamentoId: _selectedDeptId!,
              prioridadeId: _selectedPriorityId!,
              projetoId: _selectedProjectId,
              usuarioId: _selectedResponsibleId,
              statusId: _selectedStatusId,
              dataPrazo: dueStr,
              dataConclusao: completionStr,
            );
      }

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? 'Tarefa atualizada com sucesso.'
                  : 'Tarefa criada com sucesso.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      if (e is ApiError) {
        if (e.errors != null) {
          setState(() {
            _fieldErrors = e.errors!;
          });
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.message)));
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final metadataState = ref.watch(metadataControllerProvider);
    final projectsState = ref.watch(projectsControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // RBAC: Check role permissions
    final userRole = authState.user?.usuario?.cargo?.nome.toLowerCase() ?? '';
    final isAdmin = authState.user?.isAdmin ?? false;
    final isCoordenador = userRole.contains('coordenad') || isAdmin;

    // Responsible dropdown options
    // Any active user can be assigned, but we can filter by department if department is selected
    final allUsers = metadataState.usuarios;
    final filteredUsers = _selectedDeptId == null
        ? allUsers
        : allUsers.where((u) {
            final dept = u['departamento'];
            return dept is Map<String, dynamic> &&
                (dept['id'] as num).toInt() == _selectedDeptId;
          }).toList();

    final isEdit = widget.task != null;

    return Padding(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEdit ? 'Editar Tarefa' : 'Criar Nova Tarefa',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (metadataState.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          else
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title field
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título da Tarefa',
                          prefixIcon: const Icon(Icons.title),
                          errorText: _fieldErrors['titulo']?.first,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Insira o título da tarefa.'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // Project dropdown
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _selectedProjectId,
                        decoration: InputDecoration(
                          labelText: 'Projeto (Opcional)',
                          prefixIcon: const Icon(Icons.folder_outlined),
                          errorText: _fieldErrors['projeto_id']?.first,
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text(
                              'Nenhum',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ...projectsState.items.map(
                            (p) => DropdownMenuItem(
                              value: p.id,
                              child: Text(
                                p.nome,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedProjectId = val),
                      ),
                      const SizedBox(height: 14),

                      // Department dropdown
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _selectedDeptId,
                        decoration: InputDecoration(
                          labelText: 'Departamento (Obrigatório)',
                          prefixIcon: const Icon(Icons.business_center),
                          errorText: _fieldErrors['departamento_id']?.first,
                        ),
                        items: metadataState.departamentos
                            .map(
                              (d) => DropdownMenuItem(
                                value: d.id,
                                child: Text(
                                  d.nome,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedDeptId = val;
                            // reset responsible if no longer belongs to department filter
                            _selectedResponsibleId = null;
                          });
                        },
                      ),
                      const SizedBox(height: 14),

                      // Priority dropdown
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _selectedPriorityId,
                        decoration: InputDecoration(
                          labelText: 'Prioridade',
                          prefixIcon: const Icon(Icons.priority_high),
                          errorText: _fieldErrors['prioridade_id']?.first,
                        ),
                        items: metadataState.prioridades
                            .map(
                              (p) => DropdownMenuItem(
                                value: p.id,
                                child: Text(
                                  p.nome,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedPriorityId = val),
                      ),
                      const SizedBox(height: 14),

                      // Responsible dropdown (Only editable by Admin or Coordenador)
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _selectedResponsibleId,
                        decoration: InputDecoration(
                          labelText: 'Responsável',
                          prefixIcon: const Icon(Icons.person_outline),
                          errorText: _fieldErrors['usuario_id']?.first,
                          helperText: !isCoordenador
                              ? 'Apenas Coordenadores ou Admins podem atribuir responsável.'
                              : null,
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text(
                              'Não atribuído',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ...filteredUsers.map(
                            (u) => DropdownMenuItem<int>(
                              value: (u['id'] as num).toInt(),
                              child: Text(
                                u['nome'].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                        onChanged: !isCoordenador
                            ? null // Read-only for Gestors or Designers
                            : (val) =>
                                  setState(() => _selectedResponsibleId = val),
                      ),
                      const SizedBox(height: 14),

                      // Status (Only editable by Admin or Coordenador)
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: _selectedStatusId,
                        decoration: InputDecoration(
                          labelText: 'Estado',
                          prefixIcon: const Icon(Icons.info_outline),
                          errorText: _fieldErrors['status_id']?.first,
                          helperText: !isCoordenador
                              ? 'Apenas Coordenadores ou Admins podem alterar o estado.'
                              : null,
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text(
                              'Por produzir (Default)',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ...metadataState.statusTarefas.map(
                            (s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(
                                s.nome,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ],
                        onChanged: !isCoordenador
                            ? null // Read-only
                            : (val) => setState(() => _selectedStatusId = val),
                      ),
                      const SizedBox(height: 14),

                      // Due Date datepicker
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, true),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Prazo da Tarefa',
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  errorText: _fieldErrors['data_prazo']?.first,
                                ),
                                child: Text(
                                  _dueDate == null
                                      ? 'Opcional'
                                      : DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(_dueDate!),
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.ink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Completion Date datepicker (Only editable by Admin or Coordenador)
                          Expanded(
                            child: InkWell(
                              onTap: !isCoordenador
                                  ? null // Disabled for Gestors and other roles
                                  : () => _selectDate(context, false),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Data Conclusão',
                                  prefixIcon: const Icon(
                                    Icons.check_circle_outline,
                                  ),
                                  errorText:
                                      _fieldErrors['data_conclusao']?.first,
                                ),
                                child: Text(
                                  _completionDate == null
                                      ? 'Pendente'
                                      : DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(_completionDate!),
                                  style: TextStyle(
                                    color: !isCoordenador
                                        ? Colors.grey
                                        : (isDark
                                              ? Colors.white
                                              : AppColors.ink),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Description field
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Descrição detalhada',
                          alignLabelWithHint: true,
                          prefixIcon: const Icon(Icons.description_outlined),
                          errorText: _fieldErrors['descricao']?.first,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Insira a descrição.'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Action button
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: AppColors.brandGradient,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _isSaving ? null : _submit,
                          child: _isSaving
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  isEdit ? 'Salvar Alterações' : 'Criar Tarefa',
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
