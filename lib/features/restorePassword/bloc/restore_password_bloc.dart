import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/edit_profile/bloc/edit_profile_event.dart';
import 'package:query_quest/features/edit_profile/bloc/edit_profile_state.dart';
import 'package:query_quest/features/restorePassword/bloc/restore_password_event.dart';
import 'package:query_quest/features/restorePassword/bloc/restore_password_state.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';
import 'package:query_quest/repositories/shared_prefs/shared_preferences.dart';

class RestorePasswordBloc extends Bloc<RestorePasswordEvent, RestorePasswordState>{

  final AuthRepository authRepository = AuthRepository();
  final SharedPrefs sharedPrefs = SharedPrefs();

  RestorePasswordBloc() : super(DefaultRestorePasswordState()){
    on<RestorePasswordRequestEvent>(_restorePasswordHandler);
    on<CheckRestoreCodeEvent>(_checkCodeHandler);
    on<ResetRestorePasswordScreenEvent>(_resetScreenHandler);
    on<ChangePasswordEvent>(_changePasswordHandler);
  }

  Future<void> _restorePasswordHandler(RestorePasswordRequestEvent event, Emitter<RestorePasswordState> emitter) async {
    try{
      emitter(LoadingRestorePasswordState());
      final status = await authRepository.restorePasswordRequest(event.email);
      emitter(SuccessRestorePasswordState(status['message']!));
      emitter(EnterPasswordCodeState(event.email, ""));
    }
    catch(error){
      emitter(ErrorRestorePasswordState(error.toString()));
      emitter(DefaultRestorePasswordState());
    }
  }

  Future<void> _checkCodeHandler(CheckRestoreCodeEvent event, Emitter<RestorePasswordState> emitter) async {
    try{
      emitter(LoadingRestorePasswordState());
      final status = await authRepository.checkRestoreCode(event.email, event.code);
      emitter(SuccessRestorePasswordState(status['message']!));
      emitter(EnterNewPasswordState(event.email, "", ""));
    }
    catch(error){
      emitter(ErrorRestorePasswordState(error.toString()));
      emitter(EnterPasswordCodeState(event.email, ""));
    }
  }

  Future<void> _changePasswordHandler(ChangePasswordEvent event, Emitter<RestorePasswordState> emitter) async {
    try{
      emitter(LoadingRestorePasswordState());
      final status = await authRepository.restorePassword(event.email, event.code, event.password);
      emitter(SuccessRestorePasswordState(status['message']!));
      emitter(SuccessChangePasswordState());
    }
    catch(error){
      emitter(ErrorRestorePasswordState(error.toString()));
      emitter(EnterNewPasswordState(event.email, event.code, ""));
    }
  }

  Future<void> _resetScreenHandler(ResetRestorePasswordScreenEvent event, Emitter<RestorePasswordState> emitter) async {
    try{
      emitter(DefaultRestorePasswordState());
    }
    catch(error){
      emitter(ErrorRestorePasswordState(error.toString()));
      emitter(DefaultRestorePasswordState());
    }
  }
}