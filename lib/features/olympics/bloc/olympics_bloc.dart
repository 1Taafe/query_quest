import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/olympics/bloc/olympics_event.dart';
import 'package:query_quest/repositories/models/Answer.dart';
import 'package:query_quest/repositories/olympics/OlympicsRepository.dart';
import 'package:query_quest/repositories/shared_prefs/shared_preferences.dart';
import '../../../repositories/models/Result.dart';
import 'olympics_state.dart';

class OlympicsBloc extends Bloc<OlympicsEvent, OlympicsState>{

  final olympicsRepository = OlympicsRepository();
  final sharedPrefs = SharedPrefs();

  OlympicsBloc() : super(OlympicsEmptyState()){
    on<OlympicsLoadEvent>(_loadOlympicsHandler);
  }

  Future<void> _loadOlympicsHandler(OlympicsLoadEvent event, Emitter<OlympicsState> emitter) async {
    try{
      emitter(OlympicsLoadingState());
      final token = await sharedPrefs.getToken();
      final olympics = await olympicsRepository.getOlympicsById(token, event.olympicsId);
      final currentTime = await olympicsRepository.getServerTime();
      if(olympics.isAccessed!){
        final tasks = await olympicsRepository.getOlympicsTasks(token, olympics.id!);
        emitter(OlympicsAvailableState(olympics, tasks));
      }
      else{
        if(!olympics.isFinished!){
          emitter(OlympicsUnavailableState(olympics, currentTime, Result(), List<Answer>.empty()));
        }
        else{
          final result = await olympicsRepository.getUserResults(token, event.olympicsId);
          final answers = await olympicsRepository.getUserAnswers(token, event.olympicsId);
          emitter(OlympicsUnavailableState(olympics, currentTime, result['result'], answers['answers']));
        }
      }
    }
    catch(error){
      print(error);
      emitter(OlympicsErrorState(error.toString()));
    }
  }

}