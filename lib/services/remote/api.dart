import '../../entities/task.dart';

abstract class Api {
  Future<Map<String, dynamic>> getTodos();

  Future<int> addTask(Task task, int revision);

  Future<int> deleteTask(String taskId, int revision);

  Future<int> editTask(Task task, int revision);

  Future<Map<String, dynamic>> updateData(int revision, List<Task> localTasks);
}
