import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/login/bloc/LoginEvent.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import 'package:query_quest/repositories/shared_prefs/shared_preferences.dart';

import '../../../repositories/models/User.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final SharedPrefs sharedPrefs = SharedPrefs();
  final AuthRepository authRepository = AuthRepository();

  LoginBloc() : super(TokenCheckingState()){
    on<CheckTokenEvent>(_checkTokenHandler);
    on<UserLoginEvent>(_loginUserHandler);
  }

  Future<void> _checkTokenHandler(LoginEvent event, Emitter<LoginState> emitter) async {
    try{
      emitter(UserLoginState());
      final String token = await sharedPrefs.getToken();
      final status = await authRepository.checkToken(token);
      emitter(SuccessfulLoginState(status));
      emitter(NeedToLoginState());
    }
    catch (error){
      emitter(NeedToLoginState());
    }
  }

  Future<void> _loginUserHandler(LoginEvent event, Emitter<LoginState> emitter) async  {
    try{
      emitter(UserLoginState());
      User user = (event as UserLoginEvent).user;
      var status = await authRepository.loginUser(user);
      await sharedPrefs.saveToken(status['access_token']!);
      await Future.delayed(Duration(seconds: 3));
      emitter(SuccessfulLoginState(status));
      emitter(NeedToLoginState());
    }
    catch(error){
      emitter(ErrorLoginState(error.toString()));
    }
  }
}