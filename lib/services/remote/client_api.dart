import 'dart:developer';

import 'package:dio/dio.dart';

import '../../entities/task.dart';
import 'api.dart';
import 'api_urls.dart';
import 'dio_exceptions.dart';

String token = 'seismographer';

class ClientAPI implements Api {
  ClientAPI._();
  static final instance = ClientAPI._();

  final _dio = Dio();

  @override
  Future<Map<String, dynamic>> getTodos() async {
    String url = ApiUrls.baseUrl + ApiUrls.listUrl;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'content-type': 'aapplication/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    Options options = Options(
      headers: headers,
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
    try {
      var response = await _dio.get(url, options: options);
      log('ЗАГРУЗИЛИ все задачи с сервера');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future<int> addTask(Task task, int revision) async {
    String url = ApiUrls.baseUrl + ApiUrls.listUrl;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(
      headers: headers,
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
    var jsonTask = task.toJson();
    var data = {
      "element": jsonTask,
    };
    try {
      var response = await _dio.post(url, options: options, data: data);
      log('ДОБАВИЛИ задачу c id ${task.id} на сервер');
      return response.data['revision'];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future<int> deleteTask(String taskId, int revision) async {
    String url = '${ApiUrls.baseUrl}${ApiUrls.listUrl}/$taskId';
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(
      headers: headers,
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );

    try {
      var response = await _dio.delete(url, options: options);
      log('УДАЛИЛИ задачу c id $taskId с сервера');
      return response.data['revision'];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future<int> editTask(Task task, int revision) async {
    String url = '${ApiUrls.baseUrl}${ApiUrls.listUrl}/${task.id}';
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(
      headers: headers,
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
    var jsonTask = task.toJson();
    var data = {
      "element": jsonTask,
    };
    try {
      var response = await _dio.put(url, options: options, data: data);
      log('ИЗМЕНИЛИ задачу с id ${task.id} на сервере');
      return response.data['revision'];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  @override
  Future<Map<String, dynamic>> updateData(
      int revision, List<Task> localTasks) async {
    String url = ApiUrls.baseUrl + ApiUrls.listUrl;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(
      headers: headers,
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    );
    var jsonList = [for (Task task in localTasks) task.toJson()];
    var data = {
      "list": jsonList,
    };
    log('ОТПРАВЛЯЕМ НА СЕРВЕР $data');
    try {
      var response = await _dio.patch(url, options: options, data: data);

      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
