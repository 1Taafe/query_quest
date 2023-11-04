import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:query_quest/repositories/models/Olympics.dart';
import 'package:query_quest/repositories/models/Task.dart';

import '../exceptions/AppException.dart';
import '../models/Answer.dart';
import '../models/User.dart';

class OlympicsRepository {
  final dio = Dio();
  final String url = 'http://localhost:3000';

  Future<Map<String, dynamic>> executeQueryAsUser(String token, int taskId, String query) async {
    try{
      final response = await dio.post(
          '$url/olympics/tasks/$taskId/check',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
          data: {
            'query': query
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['message'] = response.data['message'].toString();
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Answer> getAnswer(String token, int taskId) async {
    try{
      final response = await dio.get(
          '$url/olympics/tasks/$taskId/answer',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );

      final answer = Answer();
      if(response.data.toString().isNotEmpty){
        answer.id = response.data['id'];
        answer.taskId = response.data['taskId'];
        answer.query = response.data['query'];
        answer.score = response.data['score'];
        answer.result = response.data['result'];
        answer.time = DateTime.tryParse(response.data['time']);
      }
      return answer;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Task> getTaskById(String token, int taskId) async {
    try{
      final response = await dio.get(
          '$url/olympics/tasks/$taskId',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );

      final Task task = Task();
      task.id = response.data['id'];
      task.title = response.data['title'];
      task.olympicsId = response.data['olympicsId'];
      task.solution = response.data['solution'];

      return task;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> executeQuery(String token, int olympcicsId, String query) async {
    try{
      final response = await dio.post(
          '$url/olympics/$olympcicsId',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
          data: {
            'query': query
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['result'] = response.data['result'].toString();
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> updateTask(String token, Task task) async {
    try{
      final response = await dio.put(
          '$url/olympics/task/${task.id}',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
          data: {
            'title': task.title,
            'solution': task.solution,
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['message'] = response.data['message'];
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> deleteTask(String token, int taskId) async {
    try{
      final response = await dio.delete(
          '$url/olympics/task/$taskId',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['message'] = response.data['message'];
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        }
        else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      }
      else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> createTask(String token, Task task) async {
    try{
      final response = await dio.post(
          '$url/olympics/task',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
          data: {
            'olympicsId': task.olympicsId,
            'title': task.title,
            'solution': task.solution,
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['message'] = response.data['message'];
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        }
        else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      }
      else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<List<Task>> getOlympicsTasks(String token, int olympicsId) async {
    try{
      final response = await dio.get(
          '$url/olympics/$olympicsId/tasks',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );

      List<Task> tasks = [];
      for(final dataElement in response.data){
        final task = Task();
        task.id = dataElement['id'];
        task.olympicsId = dataElement['olympicsId'];
        task.title = dataElement['title'];
        task.solution = dataElement['solution'];
        tasks.add(task);
      }
      return tasks;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<String> getServerTime() async {
    try{
      final response = await dio.get(
          '$url/olympics/currentTime',
      );
      return response.data!;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Olympics> getOlympicsById(String token, int olympicsId) async {
    try{
      final response = await dio.get(
          '$url/olympics/$olympicsId',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );

      final olympics = Olympics(
          response.data['id'],
          response.data['creatirId'],
          response.data['name'],
          response.data['description'],
          response.data['startTime'],
          response.data['endTime'],
          response.data['databaseScript'],
          response.data['databaseName'],
          response.data['image']);
      olympics.isAccessed = response.data['isAccessed'];
      olympics.creator = User();
      olympics.creator?.email = response.data['creator']['email'];
      olympics.creator?.surname = response.data['creator']['surname'];
      olympics.creator?.name = response.data['creator']['name'];
      return olympics;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> deleteOlympics(String token, int olympicsId) async {
    try{
      final response = await dio.delete(
          '$url/olympics/$olympicsId',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['message'] = response.data['message'];
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<Map<String, dynamic>> createOlympics(String token, Olympics olympics) async {
    try{
      final response = await dio.post(
          '$url/olympics/create',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          ),
          data: {
            'name': olympics.name,
            'startTime': olympics.startTime,
            'endTime': olympics.endTime,
            'description': olympics.description,
            'databaseScript': olympics.databaseScript,
            'databaseName': olympics.databaseName,
            'image': olympics.image,
          }
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        Map<String, dynamic> status = Map<String, dynamic>();
        status['status'] = 'Олимпиада успешно создана';
        olympics.id = response.data['id'];
        status['olympics'] = olympics;
        return status;
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

  Future<List<Olympics>> getOlympics(String token, String path) async {
    try{
      final response = await dio.get(
          '$url/olympics/$path',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );

      List<Olympics> olympics = [];
      for(final dataElement in response.data){
        final olympicsElement = Olympics(
            dataElement['id'],
            dataElement['creatirId'],
            dataElement['name'],
            dataElement['description'],
            dataElement['startTime'],
            dataElement['endTime'],
            dataElement['databaseScript'],
            dataElement['databaseName'],
            dataElement['image']);
        olympics.add(olympicsElement);
      }
      return olympics;
    }
    catch(error){
      if (error is DioException) {
        if (error.response != null) {
          throw AppException(error.response!.data['message'].toString());
        } else {
          throw AppException('Network error occurred'); // Handle network errors
        }
      } else {
        throw AppException('An error occurred: $error'); // Handle other errors
      }
    }
  }

}