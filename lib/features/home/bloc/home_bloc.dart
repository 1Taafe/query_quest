import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/models/Role.dart';
import '../home_feature.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import '../../../../repositories/shared_prefs/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final SharedPrefs sharedPrefs = SharedPrefs();
  final AuthRepository authRepository = AuthRepository();

  HomeBloc() : super(LoadingState()){
    on<LogoutEvent>(_logoutHandler);
    on<GetUserInfoEvent>(_roleHandler);
  }

  Future<void> _roleHandler(GetUserInfoEvent event, Emitter<HomeState> emitter) async {
    try{
      final token = await sharedPrefs.getToken();
      final currentUser = await authRepository.getUserProfile(token);
      if(currentUser.role == Role.Organizer){
        emitter(DefaultOrganizerState(currentUser));
      }
      else if(currentUser.role == Role.User){
        emitter(DefaultState(currentUser));
      }
    }
    catch(error){
      emitter(ErrorHomeState(error.toString()));
    }
  }

  Future<void> _logoutHandler(HomeEvent event, Emitter<HomeState> emitter) async {
    sharedPrefs.removeToken();
    emitter(LogoutState());
  }

}