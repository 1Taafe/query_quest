import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:query_quest/repositories/models/Olympics.dart';

import '../exceptions/AppException.dart';

class OlympicsRepository {
  final dio = Dio();
  final String url = 'http://localhost:3000';

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