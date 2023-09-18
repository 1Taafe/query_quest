import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/repositories/auth/AuthRepository.dart';

import '../../../repositories/models/User.dart';
import 'SignupEvent.dart';
import 'SignupState.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  final AuthRepository repository;

  SignupBloc(this.repository) : super(DefaultSingupState()){
    on<SignupUserEvent>(_signupUserHandler);
  }

  Future<void> _signupUserHandler(SignupEvent event, Emitter<SignupState> emitter) async {
    try {
      emitter(FetchSignupState());
      User user = (event as SignupUserEvent).user;
      String status = await repository.signupUser(user);
      emitter(SuccessfulSignupState(status));
    }
    catch (e) {
      emitter(ErrorSignupState(e.toString()));
    }
  }
}