import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/home/olympicsBloc/OlympicsEvent.dart';
import 'package:query_quest/features/home/olympicsBloc/OlympicsState.dart';
import 'package:query_quest/repositories/olympics/OlympicsRepository.dart';

import '../../../repositories/shared_prefs/shared_preferences.dart';

class OlympicsBloc extends Bloc<OlympicsEvent, OlympicsState>{

  final OlympicsRepository olympicsRepository;
  final SharedPrefs sharedPrefs;

  OlympicsBloc(this.olympicsRepository, this.sharedPrefs) : super(GetOlympicsState()){
    on<GetPlannedOlympicsEnvent>(_getOlympicsHandler);
    on<GetCurrentOlympicsEnvent>(_getOlympicsHandler);
    on<GetFinishedOlympicsEnvent>(_getOlympicsHandler);
  }

  Future<void> _getOlympicsHandler(OlympicsEvent event, Emitter<OlympicsState> emitter) async {
    try{
      emitter(GetOlympicsState());
      final token = await sharedPrefs.getToken();
      final olympics = await olympicsRepository.getOlympics(token, event.path);
      if(olympics.isEmpty){
        emitter(EmptyOlympicsState());
      }
      else{
        emitter(DefaultOlympicsState(olympics));
      }
    }
    catch(error){
      //print(error);
      emitter(ErrorOlympicsState());
    }
  }
}