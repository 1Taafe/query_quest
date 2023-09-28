
import 'package:flutter_bloc/flutter_bloc.dart';
import '../create_olympics_feature.dart';

class CreateOlympicsBloc extends Bloc<CreateOlympicsEvent, CreateOlympicsState>{

  CreateOlympicsBloc() : super(DefaultCreateOlympicsState()){
    on<CreateCurrentOlympicsEvent>(_createOlympicsHandler);
  }

  Future<void> _createOlympicsHandler(CreateCurrentOlympicsEvent event, Emitter<CreateOlympicsState> emitter) async {
    try{

    }
    catch(error){
      emitter(ErrorCreateOlympicsState(error.toString()));
    }
  }
}