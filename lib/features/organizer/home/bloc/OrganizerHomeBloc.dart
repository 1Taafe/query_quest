import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/organizer/home/organizer_home_feature.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import '../../../../repositories/shared_prefs/shared_preferences.dart';

class OrganizerHomeBloc extends Bloc<OrganizerHomeEvent, OrganizerHomeState>{

  final SharedPrefs sharedPrefs = SharedPrefs();
  final AuthRepository authRepository = AuthRepository();

  OrganizerHomeBloc() : super(GetOrganizerProfileState()){
    on<GetOrganizerProfileEvent>(_getOrganizerProfileHandler);
    on<OrganizerLogoutEvent>(_organizerLogoutHandler);
  }

  Future<void> _getOrganizerProfileHandler(GetOrganizerProfileEvent event, Emitter<OrganizerHomeState> emitter) async {
    try{
      emitter(GetOrganizerProfileState());
      final currentUser = await authRepository.getUserProfile(event.token);
      emitter(OrganizerDefaultState(currentUser));
    }
    catch(error){
      //print(error);
      emitter(OrganizerErrorHomeState(error.toString()));
    }
  }

  Future<void> _organizerLogoutHandler(OrganizerHomeEvent event, Emitter<OrganizerHomeState> emitter) async {
    sharedPrefs.removeToken();
    emitter(OrganizerLogoutState());
  }

}