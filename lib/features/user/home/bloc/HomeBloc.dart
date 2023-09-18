import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/user/home/bloc/HomeEvent.dart';
import 'package:query_quest/features/user/home/bloc/HomeState.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import '../../../../repositories/models/Database.dart';
import '../../../../repositories/shared_prefs/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final SharedPrefs sharedPrefs = SharedPrefs();
  final AuthRepository authRepository = AuthRepository();

  HomeBloc() : super(GetUserProfileState()){
    on<GetUserProfileEvent>(_getUserProfileHandler);
    on<LogoutEvent>(_logoutHandler);
    on<SetDatabaseEvent>(_setDatabaseHandler);
  }

  Future<void> _setDatabaseHandler(SetDatabaseEvent event, Emitter<HomeState> emitter) async {
    try{
      sharedPrefs.saveDatabase(event.database);
      event.user.database = event.database;
      emitter(DefaultState(event.user));
    }
    catch(error){
      emitter(ErrorHomeState(error.toString()));
    }
  }

  Future<void> _getUserProfileHandler(GetUserProfileEvent event, Emitter<HomeState> emitter) async {
    try{
      emitter(GetUserProfileState());
      final currentUser = await authRepository.getUserProfile(event.token);
      final database = await sharedPrefs.getDatabase();
      if(database == Database.Unknown){
        sharedPrefs.saveDatabase(Database.Postgresql);
        currentUser.database = Database.Postgresql;
      }
      else{
        currentUser.database = database;
      }
      emitter(DefaultState(currentUser));
    }
    catch(error){
      //print(error);
      emitter(ErrorHomeState(error.toString()));
    }
  }

  Future<void> _logoutHandler(HomeEvent event, Emitter<HomeState> emitter) async {
    sharedPrefs.removeToken();
    emitter(LogoutState());
  }

}