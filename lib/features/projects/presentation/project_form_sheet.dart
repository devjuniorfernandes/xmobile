import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/network/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/project_model.dart';
import '../../auth/auth_controller.dart';
import '../../shared/metadata_controller.dart';
import 'projects_controller.dart';

class ProjectFormSheet extends ConsumerStatefulWidget {
  const ProjectFormSheet({super.key, this.project});

  final Project? project;

  @override
  ConsumerState<ProjectFormSheet> createState() => _ProjectFormSheetState();
}

class _ProjectFormSheetState extends ConsumerState<ProjectFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  int? _selectedCompanyId;
  int? _selectedResponsibleId;
  String? _selectedStatus;

  DateTime? _startDate;
  DateTime? _dueDate;

  bool _isSaving = false;
  Map<String, List<String>> _fieldErrors = {};

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _nameController = TextEditingController(text: p?.nome ?? '');
    _descriptionController = TextEditingController(text: p?.descricao ?? '');

    _selectedCompanyId = p?.empresa?.id;
    _selectedResponsibleId = p?.responsavel?.id == 0 ? null : p?.responsavel?.id;
    _selectedStatus = p?.statusProjeto;

    if (p?.dataInicio != null) {
      _startDate = DateTime.tryParse(p!.dataInicio!);
    } else {
      _startDate = DateTime.now(); // default to today
    }
    if (p?.dataPrazo != null) {
      _dueDate = DateTime.tryParse(p!.dataPrazo!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_dueDate ?? (_startDate ?? DateTime.now()).add(const Duration(days: 30)));
    
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.pantone172C,
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
        if (isStartDate) {
          _startDate = picked;
          if (_dueDate != null && _dueDate!.isBefore(_startDate!)) {
            _dueDate = null; // reset due date if it conflicts
          }
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    setState(() {
      _fieldErrors = {};
    });

    if (!_formKey.currentState!.validate()) return;

    if (_selectedCompanyId == null) {
      setState(() {
        _fieldErrors['empresa_id'] = ['Selecione a empresa associada.'];
      });
      return;
    }

    if (_selectedResponsibleId == null) {
      setState(() {
        _fieldErrors['usuario_id'] = ['Selecione o responsável pelo projeto.'];
      });
      return;
    }

    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a data de início.')),
      );
      return;
    }

    if (_dueDate != null && _dueDate!.isBefore(_startDate!)) {
      setState(() {
        _fieldErrors['data_prazo'] = ['A data limite deve ser posterior à data de início.'];
      });
      return;
    }

    setState(() => _isSaving = true);

    try {
      final formatter = DateFormat('yyyy-MM-dd');
      final startStr = formatter.format(_startDate!);
      final dueStr = _dueDate != null ? formatter.format(_dueDate!) : null;

      final isEdit = widget.project != null;

      if (isEdit) {
        await ref.read(projectsControllerProvider.notifier).updateProject(
              id: widget.project!.id,
              nome: _nameController.text.trim(),
              empresaId: _selectedCompanyId!,
              usuarioId: _selectedResponsibleId!,
              dataInicio: startStr,
              dataPrazo: dueStr,
              descricao: _descriptionController.text.trim(),
              statusProjeto: _selectedStatus,
            );
      } else {
        await ref.read(projectsControllerProvider.notifier).createProject(
              nome: _nameController.text.trim(),
              empresaId: _selectedCompanyId!,
              usuarioId: _selectedResponsibleId!,
              dataInicio: startStr,
              dataPrazo: dueStr,
              descricao: _descriptionController.text.trim(),
              statusProjeto: _selectedStatus,
            );
      }

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? 'Projeto atualizado com sucesso.'
                  : 'Projeto criado com sucesso.',
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final metadataState = ref.watch(metadataControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Filter responsible users: must have 'Gestor' or 'Coordenador' roles
    final filteredUsers = metadataState.usuarios.where((u) {
      final cargo = u['cargo']?.toString().toLowerCase() ?? '';
      return cargo.contains('gestor') || cargo.contains('coordenad') || cargo.contains('admin');
    }).toList();

    // If current user is a GESTOR and creating a new project, set them as the responsible automatically
    final userProfile = authState.user?.usuario;
    final isGestor = userProfile?.cargo?.nome.toLowerCase().contains('gestor') ?? false;
    final isEdit = widget.project != null;

    if (!isEdit && isGestor && _selectedResponsibleId == null && userProfile != null) {
      // Auto-select current manager
      _selectedResponsibleId = userProfile.id;
    }

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
                isEdit ? 'Editar Projeto' : 'Criar Novo Projeto',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          const SizedBox(height: 14),
          if (metadataState.isLoading)
            const Center(child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ))
          else
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome do Projeto',
                          prefixIcon: const Icon(Icons.folder_outlined),
                          errorText: _fieldErrors['nome']?.first,
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Insira o nome do projeto.' : null,
                      ),
                      const SizedBox(height: 14),

                      // Company dropdown
                      DropdownButtonFormField<int>(
                        initialValue: _selectedCompanyId,
                        decoration: InputDecoration(
                          labelText: 'Empresa',
                          prefixIcon: const Icon(Icons.business),
                          errorText: _fieldErrors['empresa_id']?.first,
                        ),
                        items: metadataState.empresas
                            .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.nome),
                                ))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedCompanyId = val),
                      ),
                      const SizedBox(height: 14),

                      // Responsible dropdown (Hidden or disabled if Gestor is creating since they must be responsible)
                      DropdownButtonFormField<int>(
                        initialValue: _selectedResponsibleId,
                        decoration: InputDecoration(
                          labelText: 'Responsável',
                          prefixIcon: const Icon(Icons.person_outline),
                          errorText: _fieldErrors['usuario_id']?.first,
                        ),
                        // Gestors cannot choose responsible when creating/editing projects
                        items: filteredUsers
                            .map((u) => DropdownMenuItem<int>(
                                  value: (u['id'] as num).toInt(),
                                  child: Text("${u['nome']} (${u['cargo']})"),
                                ))
                            .toList(),
                        onChanged: (isEdit && isGestor)
                            ? null // Read-only for Gestors
                            : (val) => setState(() => _selectedResponsibleId = val),
                      ),
                      const SizedBox(height: 14),

                      // Status (only shown on edit or creation optional)
                      DropdownButtonFormField<String>(
                        initialValue: _selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Status do Projeto',
                          prefixIcon: const Icon(Icons.info_outline),
                          errorText: _fieldErrors['status_projeto']?.first,
                        ),
                        items: metadataState.statusProjetos
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s),
                                ))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedStatus = val),
                      ),
                      const SizedBox(height: 14),

                      // Dates row
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, true),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Data de Início',
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  errorText: _fieldErrors['data_inicio']?.first,
                                ),
                                child: Text(
                                  _startDate == null
                                      ? 'Selecione'
                                      : DateFormat('dd/MM/yyyy').format(_startDate!),
                                  style: TextStyle(
                                    color: isDark ? Colors.white : AppColors.ink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, false),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Data Limite (Prazo)',
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  errorText: _fieldErrors['data_prazo']?.first,
                                ),
                                child: Text(
                                  _dueDate == null
                                      ? 'Opcional'
                                      : DateFormat('dd/MM/yyyy').format(_dueDate!),
                                  style: TextStyle(
                                    color: isDark ? Colors.white : AppColors.ink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Descrição do Projeto',
                          alignLabelWithHint: true,
                          prefixIcon: const Icon(Icons.description_outlined),
                          errorText: _fieldErrors['descricao']?.first,
                        ),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(isEdit ? 'Salvar Alterações' : 'Criar Projeto'),
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
