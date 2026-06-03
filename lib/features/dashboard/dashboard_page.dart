import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_skeleton.dart';
import '../auth/auth_controller.dart';
import '../projects/presentation/projects_controller.dart';
import '../tasks/presentation/tasks_controller.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final projectsState = ref.watch(projectsControllerProvider);
    final tasksState = ref.watch(tasksControllerProvider);

    final loading = projectsState.isLoading || tasksState.isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final user = auth.user;
    final userName = user?.name ?? 'Utilizador';

    // Calculate dashboard statistics
    final activeProjects = projectsState.items.where((p) {
      final status = (p.statusProjeto ?? '').toLowerCase();
      return !status.contains('concl') && !status.contains('cancel');
    }).toList();

    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return 'Bom dia';
      if (hour < 18) return 'Boa tarde';
      return 'Boa noite';
    }

    return Scaffold(
      body: loading
          ? const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: AppSkeleton(rows: 5),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await Future.wait([
                  ref.read(projectsControllerProvider.notifier).refresh(),
                  ref.read(tasksControllerProvider.notifier).refresh(),
                ]);
              },
              child: CustomScrollView(
                slivers: [
                  // Custom Premium Header
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF0F172A)
                            : AppColors.pantone715C,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // User Greeting Row
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: AppColors.pantone172C,
                                child: Text(
                                  userName.isNotEmpty
                                      ? userName.substring(0, 1).toUpperCase()
                                      : 'X',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${getGreeting()},',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: isDark
                                                ? Colors.white60
                                                : AppColors.muted,
                                          ),
                                    ),
                                    Text(
                                      userName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              // Circular Search and Notification buttons
                              _CircularIconButton(
                                icon: Icons.search,
                                onTap: () => context.go('/tasks'),
                              ),
                              const SizedBox(width: 8),
                              _CircularIconButton(
                                icon: Icons.notifications_none_outlined,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Glassmorphism Meeting Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: AppColors.brandGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pantone172C.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reunião Geral de Equipa',
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.schedule,
                                            color: Colors.white70,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '15:30 Hoje',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.groups_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Your Project Header Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Os Meus Projetos',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          TextButton(
                            onPressed: () => context.go('/projects'),
                            child: const Text('Ver tudo'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Horizontal Projects Cards
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 180,
                      child: projectsState.items.isEmpty
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: const Text(
                                'Nenhum projeto ativo encontrado.',
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              itemCount: projectsState.items.length,
                              itemBuilder: (context, index) {
                                final project = projectsState.items[index];
                                final metricas = project.metricas;

                                double progress = 0;
                                if (metricas != null &&
                                    metricas.tarefasTotal > 0) {
                                  progress =
                                      metricas.tarefasConcluidas /
                                      metricas.tarefasTotal;
                                }

                                final isPrimary = index % 2 == 0;

                                return Container(
                                  width: 280,
                                  margin: const EdgeInsets.only(right: 14),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    gradient: isPrimary
                                        ? const LinearGradient(
                                            colors: [
                                              AppColors.pantone2955C,
                                              Color(0xFF1E3A8A),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xFF0D9488),
                                              Color(0xFF0F766E),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            (isPrimary
                                                    ? AppColors.pantone2955C
                                                    : const Color(0xFF0D9488))
                                                .withOpacity(0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () => context.push(
                                      '/projects/detail',
                                      extra: project,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          project.nome,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          project.empresa?.nome ??
                                              'Sem Empresa',
                                          style: GoogleFonts.roboto(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const Spacer(),
                                        // Progress Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Progresso',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              '${(progress * 100).toInt()}%',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            minHeight: 6,
                                            backgroundColor: Colors.white
                                                .withOpacity(0.2),
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(Colors.white),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Project Info Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                  color: Colors.white70,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${metricas?.tarefasTotal ?? 0} Tarefas',
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white70,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (project.dataPrazo != null)
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.white70,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    _formatDate(
                                                      project.dataPrazo,
                                                    ),
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),

                  // Priority Projects Header
                  if (activeProjects.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Text(
                          'Projetos Prioritários',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 48,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: activeProjects.length,
                          itemBuilder: (context, index) {
                            final project = activeProjects[index];
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: InputChip(
                                label: Text(project.nome),
                                avatar: Icon(
                                  Icons.folder_outlined,
                                  color: AppColors.pantone172C,
                                  size: 16,
                                ),
                                backgroundColor: isDark
                                    ? const Color(0xFF1E293B)
                                    : Colors.white,
                                side: BorderSide(color: AppColors.border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onPressed: () => context.push(
                                  '/projects/detail',
                                  extra: project,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],

                  // Today's Task Header Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tarefas de Hoje',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          TextButton(
                            onPressed: () => context.go('/tasks'),
                            child: const Text('Ver tudo'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tasks List
                  tasksState.items.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    'Nenhuma tarefa pendente para hoje.',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final task = tasksState.items[index];
                                final isTaskCompleted = (task.status ?? '')
                                    .toLowerCase()
                                    .contains('concl');

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E293B)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: InkWell(
                                    onTap: () => context.push(
                                      '/tasks/detail',
                                      extra: task,
                                    ),
                                    child: Row(
                                      children: [
                                        // Completed checkbox indicator
                                        Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isTaskCompleted
                                                  ? AppColors.success
                                                  : AppColors.muted.withOpacity(
                                                      0.4,
                                                    ),
                                              width: 2,
                                            ),
                                            color: isTaskCompleted
                                                ? AppColors.success
                                                : Colors.transparent,
                                          ),
                                          child: isTaskCompleted
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                task.titulo,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: isTaskCompleted
                                                      ? TextDecoration
                                                            .lineThrough
                                                      : null,
                                                  color: isTaskCompleted
                                                      ? AppColors.muted
                                                      : (isDark
                                                            ? Colors.white
                                                            : AppColors.ink),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      task.projeto?.nome ??
                                                          'Sem Projeto',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        color: AppColors.muted,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  if (task.prioridade !=
                                                      null) ...[
                                                    const SizedBox(width: 8),
                                                    Container(
                                                      width: 4,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.muted
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      task.prioridade!,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            _getPriorityColor(
                                                              task.prioridade,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: AppColors.muted,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: tasksState.items
                                  .take(5)
                                  .length, // Show up to 5 tasks on dashboard
                            ),
                          ),
                        ),

                  // Bottom spacing
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            ),
    );
  }

  Color _getPriorityColor(String? priority) {
    if (priority == null) return AppColors.muted;
    final lower = priority.toLowerCase();
    if (lower.contains('alt') || lower.contains('urg')) return AppColors.danger;
    if (lower.contains('med')) return AppColors.pantone1505C;
    return AppColors.success;
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null) return '';
    try {
      final parsed = DateTime.parse(rawDate);
      return DateFormat('d MMM yyyy').format(parsed);
    } catch (_) {
      return rawDate;
    }
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : AppColors.ink,
          size: 20,
        ),
      ),
    );
  }
}
