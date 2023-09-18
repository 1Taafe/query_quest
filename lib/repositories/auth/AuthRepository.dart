import 'package:dio/dio.dart';
import 'package:query_quest/repositories/exceptions/AppException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/Role.dart';
import '../models/User.dart';

class AuthRepository {
  final dio = Dio();
  final String url = 'http://localhost:3000';

  Future<User> getUserProfile(String token) async {
    try{
      final response = await dio.get(
        '$url/auth/profile',
          options: Options(
              headers:  {
                "Authorization":"Bearer $token"
              }
          )
      );
      User user = User();
      user.email = response.data['email'];
      user.course = response.data['course'];
      user.group = response.data['group'];
      user.surname = response.data['surname'];
      user.name = response.data['name'];
      user.phone = response.data['phone'];
      user.role = response.data['role'];
      return user;
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

  Future<Map<String, String>> checkToken(String token) async {
    try{
      final response = await dio.get(
        "${url}/auth/checkToken",
          options: Options(
            headers:  {
              "Authorization":"Bearer $token"
            }
            )
      );
      Map<String, String> status = Map<String, String>();
      status['access_token'] = token;
      status['status'] = response.data['status'].toString();
      status['role'] = response.data['role'].toString();
      return status;
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

  Future<Map<String, String>> loginUser(User user) async {
    try{
      final response = await dio.post(
        'http://localhost:3000/auth/login',
        data: {
          'email': user.email,
          'password': user.password,
        }
      );
      if(response.statusCode == 200){
        Map<String, String> loginStatus = Map<String, String>();
        loginStatus['status'] = response.data['status'].toString();
        loginStatus['access_token'] = response.data['access_token'].toString();
        loginStatus['role'] = response.data['role'].toString();
        return loginStatus;
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

  Future<String> signupUser(User user) async {
    try {
      final response = await dio.post(
        'http://localhost:3000/auth/signup',
        data: {
          'email': user.email,
          'password': user.password,
          'course': user.course,
          'group': user.group,
          'surname': user.surname,
          'name': user.name,
          'phone': user.phone,
        },
      );

      if (response.statusCode == 201) {
        return 'Учетная запись создана';
      }
      else {
        final parsedJson = jsonDecode(response.data);
        throw AppException(parsedJson.toString());
      }
    } catch (error) {
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