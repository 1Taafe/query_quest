import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/repositories/olympics/OlympicsRepository.dart';
import '../edit_olympics_feature.dart';

class EditOlympicsBloc extends Bloc<EditOlympicsEvent, EditOlympicsState>{

  final OlympicsRepository olympicsRepository = OlympicsRepository();

  EditOlympicsBloc() : super(EditOlympicsDefaultState()){
    //on<LogoutEvent>(_logoutHandler);
  }
}