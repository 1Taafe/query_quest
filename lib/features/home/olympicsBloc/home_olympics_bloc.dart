import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/home/olympicsBloc/home_olympics_event.dart';
import 'package:query_quest/features/home/olympicsBloc/home_olympics_state.dart';
import 'package:query_quest/repositories/olympics/OlympicsRepository.dart';

import '../../../repositories/shared_prefs/shared_preferences.dart';

class HomeOlympicsBloc extends Bloc<HomeOlympicsEvent, HomeOlympicsState>{

  final OlympicsRepository olympicsRepository;
  final SharedPrefs sharedPrefs;

  HomeOlympicsBloc(this.olympicsRepository, this.sharedPrefs) : super(GetOlympicsState()){
    on<GetOlympicsEvent>(_getOlympicsHandler);
  }

  Future<void> _getOlympicsHandler(HomeOlympicsEvent event, Emitter<HomeOlympicsState> emitter) async {
    try{
      emitter(GetOlympicsState());
      final token = await sharedPrefs.getToken();
      final olympics = await olympicsRepository.getOlympics(token, event.path);
      if(olympics.isEmpty){
        emitter(EmptyOlympicsState());
      }
      else{
        emitter(DefaultOlympicsState(olympics, event.path));
      }
    }
    catch(error){
      print(error);
      emitter(ErrorOlympicsState());
    }
  }
}