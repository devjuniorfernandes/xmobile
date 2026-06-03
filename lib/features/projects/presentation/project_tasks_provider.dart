import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/task_model.dart';
import '../../../data/repositories/tasks_repository.dart';

typedef ProjectTaskQuery = ({int projectId, String projectName});

final projectTasksProvider =
    FutureProvider.family<List<TaskItem>, ProjectTaskQuery>((ref, query) async {
      final repository = ref.watch(tasksRepositoryProvider);
      final response = await repository.getTasks(
        page: 1,
        projetoId: query.projectId,
        projeto: query.projectName,
      );
      return response.items
          .where(
            (task) =>
                task.projeto?.id == query.projectId ||
                task.projeto?.nome.toLowerCase() ==
                    query.projectName.toLowerCase(),
          )
          .toList();
    });
