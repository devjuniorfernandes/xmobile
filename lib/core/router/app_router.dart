import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/project_model.dart';
import '../../data/models/task_model.dart';
import '../../features/auth/auth_controller.dart';
import '../../features/auth/login/login_page.dart';
import '../../features/auth/splash/splash_page.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/projects/presentation/project_detail_page.dart';
import '../../features/projects/presentation/projects_page.dart';
import '../../features/tasks/presentation/task_detail_page.dart';
import '../../features/tasks/presentation/tasks_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final checking = auth.status == AuthStatus.checking;
      final loggedIn = auth.status == AuthStatus.authenticated;
      final isSplash = state.matchedLocation == '/splash';
      final isLogin = state.matchedLocation == '/login';

      if (checking) return isSplash ? null : '/splash';
      if (!loggedIn) return isLogin ? null : '/login';
      if (isLogin || isSplash) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/projects',
            builder: (context, state) => const ProjectsPage(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/projects/detail',
        builder: (context, state) =>
            ProjectDetailPage(project: state.extra! as Project),
      ),
      GoRoute(
        path: '/tasks/detail',
        builder: (context, state) =>
            TaskDetailPage(task: state.extra! as TaskItem),
      ),
    ],
  );
});

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.child});

  final Widget child;

  static const _items = [
    ('Dashboard', Icons.space_dashboard_outlined, '/dashboard'),
    ('Projetos', Icons.folder_copy_outlined, '/projects'),
    ('Tarefas', Icons.checklist_rtl_outlined, '/tasks'),
    ('Perfil', Icons.person_outline, '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = _items.indexWhere((item) => location.startsWith(item.$3));
    final selectedIndex = index < 0 ? 0 : index;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => context.go(_items[value].$3),
        destinations: _items
            .map(
              (item) =>
                  NavigationDestination(icon: Icon(item.$2), label: item.$1),
            )
            .toList(),
      ),
    );
  }
}
