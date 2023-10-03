import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/global/auth/bloc/auth_event.dart';
import 'package:query_quest/global/auth/bloc/auth_state.dart';

import '../../../repositories/auth/AuthRepository.dart';
import '../../../repositories/shared_prefs/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final SharedPrefs sharedPrefs = SharedPrefs();
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(UnauthorizedState()){
    on<TokenEvent>(_checkTokenHandler);
    on<LoginEvent>(_loginHandler);
  }

  Future<void> _checkTokenHandler(TokenEvent event, Emitter<AuthState> emitter) async {
    String token = "";
    try{
      emitter(AuthLoadingState());
      token = await sharedPrefs.getToken();
      final status = await authRepository.checkToken(token);
      final currentUser = await authRepository.getUserProfile(token);
      emitter(AuthorizedNotifyState(status['status']!));
      emitter(AuthorizedState(token, currentUser));
    }
    catch (error){
      //emitter(UnauthorizedNotifyState(error.toString()));
      emitter(UnauthorizedState());
    }
  }

  Future<void> _loginHandler(LoginEvent event, Emitter<AuthState> emitter) async  {
    try{
      emitter(AuthLoadingState());
      final user = event.user;
      var status = await authRepository.loginUser(user);
      final token = status['access_token']!;
      await sharedPrefs.saveToken(token);
      final currentUser = await authRepository.getUserProfile(token);
      emitter(AuthorizedNotifyState(status['status']!));
      emitter(AuthorizedState(token, currentUser));
    }
    catch(error){
      emitter(UnauthorizedNotifyState(error.toString()));
      emitter(UnauthorizedState());
    }
  }
}