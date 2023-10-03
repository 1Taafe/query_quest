
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/olympics/OlympicsRepository.dart';
import '../../../repositories/shared_prefs/shared_preferences.dart';
import '../create_olympics_feature.dart';

class CreateOlympicsBloc extends Bloc<CreateOlympicsEvent, CreateOlympicsState>{

  final OlympicsRepository olympicsRepository;
  final SharedPrefs sharedPrefs;

  CreateOlympicsBloc(this.olympicsRepository, this.sharedPrefs) : super(DefaultCreateOlympicsState()){
    on<CreateCurrentOlympicsEvent>(_createOlympicsHandler);
  }

  Future<void> _createOlympicsHandler(CreateCurrentOlympicsEvent event, Emitter<CreateOlympicsState> emitter) async {
    try{
      emitter(LoadingOlympicsState());
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.createOlympics(token, event.olympics);
      emitter(SuccessfulOlympicsState(status['status']!));
      emitter(DefaultCreateOlympicsState());
    }
    catch(error){
      print(error);
      emitter(ErrorCreateOlympicsState(error.toString()));
      emitter(DefaultCreateOlympicsState());
    }
  }
}