import 'dart:developer';

import 'package:dio/dio.dart';

import '../entities/task.dart';
import 'api_urls.dart';

String token = 'seismographer';

class ClientAPI {
  ClientAPI._();
  static final instance = ClientAPI._();

  final _dio = Dio();

  Future<Map<String, dynamic>> getTodos() async {
    String url = ApiUrls.baseUrl + ApiUrls.listUrl;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'content-type': 'aapplication/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    Options options = Options(headers: headers);
    var response = await _dio.get(url, options: options);
    return response.data;
  }

  Future<int> addTask(Task task, int revision) async {
    String url = ApiUrls.baseUrl + ApiUrls.listUrl;
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(headers: headers);
    var jsonTask = task.toJson();
    var data = {
      "element": jsonTask,
    };
    try {
      var response = await _dio.post(url, options: options, data: data);
      log('ДОБАВИЛИ задачу c id ${task.id} на сервер');
      return response.data['revision'];
    } on DioException catch (e) {
      throw 'Something went wrong :(\n ${e.message}';
    }
  }

  Future<int> deleteTask(String taskId, int revision) async {
    String url = '${ApiUrls.baseUrl}${ApiUrls.listUrl}/$taskId';
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(headers: headers);

    try {
      var response = await _dio.delete(url, options: options);
      log('УДАЛИЛИ задачу c id $taskId с сервера');
      return response.data['revision'];
    } on DioException catch (e) {
      throw 'Something went wrong :(\n ${e.message}';
    }
  }

  Future<int> editTask(Task task, int revision) async {
    String url = '${ApiUrls.baseUrl}${ApiUrls.listUrl}/${task.id}';
    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Last-Known-Revision': revision,
    };
    Options options = Options(headers: headers);
    var jsonTask = task.toJson();
    var data = {
      "element": jsonTask,
    };
    try {
      var response = await _dio.put(url, options: options, data: data);
      log('ИЗМЕНИЛИ задачу с id ${task.id} на сервере');
      return response.data['revision'];
    } on DioException catch (e) {
      throw 'Something went wrong :(\n ${e.message}';
    }
  }
}
