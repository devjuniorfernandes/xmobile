import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import 'task_model.dart';
import 'tasks_db.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<TaskModel> tasks = [];
  bool loading = true;
  final ScrollController _calendarController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scroll the horizontal calendar to show the current day roughly centered
      // item width ~64 (circle + padding), index 7 corresponds to today in builder
      final offset = 7 * 64.0;
      if (_calendarController.hasClients) {
        _calendarController.jumpTo(offset);
      }
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    setState(() => loading = true);
    tasks = await TasksDatabase.instance.getTasksForDay(selectedDate);
    setState(() => loading = false);
  }

  void _changeDate(DateTime date) {
    selectedDate = date;
    _loadTasks();
  }

  Future<void> _toggleDone(TaskModel task, bool? value) async {
    task.done = (value ?? false) ? 1 : 0;
    await TasksDatabase.instance.update(task);
    _loadTasks();
  }

  Future<void> _deleteTask(int id) async {
    await TasksDatabase.instance.delete(id);
    _loadTasks();
  }

  Future<void> _showAddDialog() async {
    final titleController = TextEditingController();
    DateTime date = selectedDate;
    TimeOfDay? time;
    int duration = 0;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Adicionar tarefa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data: ${DateFormat.yMd('pt_BR').format(date)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => date = picked);
                      }
                    },
                    child: const Text('Selecionar'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Hora: ${time?.format(context) ?? '-'}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() => time = picked);
                      }
                    },
                    child: const Text('Selecionar'),
                  ),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duração (min)'),
                onChanged: (v) => duration = int.tryParse(v) ?? 0,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isEmpty) return;

              final startOfDay = DateTime(date.year, date.month, date.day);
              int? timeMillis;
              if (time != null) {
                final localTime = time; // promote to local non-null variable
                final t = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  localTime!.hour,
                  localTime.minute,
                );
                timeMillis = t.millisecondsSinceEpoch;
              }

              final task = TaskModel(
                title: title,
                dateMillis: startOfDay.millisecondsSinceEpoch,
                timeMillis: timeMillis,
                durationMinutes: duration,
                done: 0,
                createdAtMillis: DateTime.now().millisecondsSinceEpoch,
              );

              await TasksDatabase.instance.create(task);
              if (!mounted) return;
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                GoRouter.of(context).go('/profile');
              }
              _loadTasks();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(TaskModel task) async {
    final titleController = TextEditingController(text: task.title);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(task.dateMillis);
    TimeOfDay? time = task.timeMillis != null
        ? TimeOfDay.fromDateTime(
            DateTime.fromMillisecondsSinceEpoch(task.timeMillis!),
          )
        : null;
    int duration = task.durationMinutes;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Editar tarefa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data: ${DateFormat.yMd('pt_BR').format(date)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => date = picked);
                      }
                    },
                    child: const Text('Selecionar'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Hora: ${time?.format(context) ?? '-'}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: time ?? TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() => time = picked);
                      }
                    },
                    child: const Text('Selecionar'),
                  ),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duração (min)'),
                controller: TextEditingController(text: duration.toString()),
                onChanged: (v) => duration = int.tryParse(v) ?? 0,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isEmpty) return;

              final startOfDay = DateTime(date.year, date.month, date.day);
              int? timeMillis;
              if (time != null) {
                final localTime = time!;
                final t = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  localTime.hour,
                  localTime.minute,
                );
                timeMillis = t.millisecondsSinceEpoch;
              }

              task.title = title;
              task.dateMillis = startOfDay.millisecondsSinceEpoch;
              task.timeMillis = timeMillis;
              task.durationMinutes = duration;

              await TasksDatabase.instance.update(task);
              if (!mounted) return;
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                GoRouter.of(context).go('/profile');
              }
              _loadTasks();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          (user?.name.isNotEmpty ?? false)
                              ? user!.name.characters.first.toUpperCase()
                              : 'X',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Usuário autenticado',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 4),
                            Text(user?.email ?? 'Sessão ativa'),
                          ],
                        ),
                      ),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () =>
                            ref.read(authControllerProvider.notifier).logout(),
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Calendar strip
          SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    DateFormat.yMMMM('pt_BR').format(selectedDate),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: _calendarController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      final day = DateTime.now().add(Duration(days: index - 7));
                      final isSelected =
                          DateTime(day.year, day.month, day.day) ==
                          DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                          );
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () => setState(() => _changeDate(day)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: isSelected ? 26 : 22,
                                backgroundColor: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.E('pt_BR').format(day),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      day.day.toString(),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: isSelected ? 16 : 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tarefas',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          if (loading) const Center(child: CircularProgressIndicator()),
          if (!loading && tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('Nenhuma tarefa para este dia')),
            ),
          if (!loading && tasks.isNotEmpty)
            ...tasks.map(
              (t) => Card(
                child: ListTile(
                  leading: Checkbox(
                    value: t.done == 1,
                    onChanged: (v) => _toggleDone(t, v),
                  ),
                  title: Text(t.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (t.timeMillis != null)
                        Text(
                          DateFormat.Hm('pt_BR').format(
                            DateTime.fromMillisecondsSinceEpoch(t.timeMillis!),
                          ),
                        ),
                      if (t.durationMinutes > 0)
                        Text('Duração: ${t.durationMinutes} min'),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) async {
                      if (v == 'delete' && t.id != null) {
                        await _deleteTask(t.id!);
                      } else if (v == 'edit') {
                        await _showEditDialog(t);
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text('Editar')),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Deletar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// _ProfileRow was removed — profile page uses inline widgets now.
