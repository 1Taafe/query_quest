import 'package:query_quest/repositories/exceptions/AppException.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Database.dart';

class SharedPrefs{
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if(token == null){
      throw new AppException('Токен отсутствует');
    }
    else {
      return token;
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> getDatabase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? database = prefs.getString('database');
    if(database == null){
      return Database.Unknown;
    }
    else {
      return database;
    }
  }

  Future<void> saveDatabase(String database) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('database', database);
  }

  Future<void> removeDatabase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('database');
  }
}