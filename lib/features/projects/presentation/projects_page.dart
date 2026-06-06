import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../auth/auth_controller.dart';
import 'project_card.dart';
import 'project_form_sheet.dart';
import 'projects_controller.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends ConsumerState<ProjectsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 320) {
        ref.read(projectsControllerProvider.notifier).loadMore();
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
    final state = ref.watch(projectsControllerProvider);
    final controller = ref.read(projectsControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);

    final userRole = authState.user?.usuario?.cargo?.nome.toLowerCase() ?? '';
    final isAdmin = authState.user?.isAdmin ?? false;
    final canCreate = userRole.contains('coordenad') || userRole.contains('gestor') || isAdmin;

    return Scaffold(
      appBar: AppBar(title: const Text('Projetos')),
      floatingActionButton: canCreate
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  builder: (context) => const ProjectFormSheet(),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: TextField(
              onChanged: controller.search,
              decoration: const InputDecoration(
                hintText: 'Pesquisar projetos',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
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
                    title: 'Sem projetos',
                    message: 'Nenhum projeto encontrado.',
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
                        final project = state.items[index];
                        return ProjectCard(
                          project: project,
                          onTap: () =>
                              context.push('/projects/detail', extra: project),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
