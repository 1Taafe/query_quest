import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:query_quest/repositories/models/Olympics.dart';

import '../exceptions/AppException.dart';

class OlympicsRepository {
  final dio = Dio();
  final String url = 'http://localhost:3000';

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

  // Future<User> getUserProfile(String token) async {
  //   try{
  //     final response = await dio.get(
  //         '$url/auth/profile',
  //         options: Options(
  //             headers:  {
  //               "Authorization":"Bearer $token"
  //             }
  //         )
  //     );
  //     User user = User();
  //     user.email = response.data['email'];
  //     user.course = response.data['course'];
  //     user.group = response.data['group'];
  //     user.surname = response.data['surname'];
  //     user.name = response.data['name'];
  //     user.phone = response.data['phone'];
  //     user.role = response.data['role'];
  //     return user;
  //   }
  //   catch(error){
  //     if (error is DioException) {
  //       if (error.response != null) {
  //         throw AppException(error.response!.data['message'].toString());
  //       } else {
  //         throw AppException('Network error occurred'); // Handle network errors
  //       }
  //     } else {
  //       throw AppException('An error occurred: $error'); // Handle other errors
  //     }
  //   }
  // }

}