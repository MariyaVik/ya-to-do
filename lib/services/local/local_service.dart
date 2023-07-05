import '../../entities/task.dart';

abstract class LocalService {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getUndoneTasks();
  Future<void> addTask(Task newTask);
  Future<void> deleteTask(String taskId);
  Future<void> editTask(Task task);
  Future<void> cleanDb();
}
