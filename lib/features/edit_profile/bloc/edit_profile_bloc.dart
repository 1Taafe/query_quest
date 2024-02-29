import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/edit_profile/bloc/edit_profile_event.dart';
import 'package:query_quest/features/edit_profile/bloc/edit_profile_state.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import 'package:query_quest/repositories/shared_prefs/shared_preferences.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState>{

  final AuthRepository authRepository;
  final SharedPrefs sharedPrefs;

  EditProfileBloc(this.authRepository, this.sharedPrefs) : super(LoadingEditProfileState()){
    on<LoadProfileEvent>(_loadProfileHandler);
  }

  Future<void> _loadProfileHandler(LoadProfileEvent event, Emitter<EditProfileState> emitter) async {
    try{

    }
    catch(error){

    }
  }
}