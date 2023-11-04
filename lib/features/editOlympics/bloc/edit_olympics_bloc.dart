import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/repositories/olympics/OlympicsRepository.dart';
import 'package:query_quest/repositories/shared_prefs/shared_preferences.dart';
import '../edit_olympics_feature.dart';

class EditOlympicsBloc extends Bloc<EditOlympicsEvent, EditOlympicsState>{

  final olympicsRepository = OlympicsRepository();
  final sharedPrefs = SharedPrefs();

  EditOlympicsBloc() : super(EditOlympicsEmptyState()){
    on<DeleteOlympicsEvent>(_deleteOlympicsHandler);
    on<LoadOlympicsEvent>(_loadOlympicsHandler);
    on<CreateTaskEvent>(_createTaskHandler);
    on<DeleteTaskEvent>(_deleteTaskHandler);
    on<UpdateTaskEvent>(_updateTaskHandler);
    on<ExecuteQueryEvent>(_executeQueryHandler);
  }

  Future<void> _executeQueryHandler(ExecuteQueryEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Выполнение запроса'));
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.executeQuery(token, event.olympics.id!, event.query);
      emitter(EditOlympicsSuccessfulState('Запрос выполнен', event.olympicsPath, false));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, status['result']));
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, ''));
    }
  }

  Future<void> _updateTaskHandler(UpdateTaskEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Изменение задания'));
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.updateTask(token, event.task);
      final olympics = await olympicsRepository.getOlympicsById(token, event.task.olympicsId!);
      final tasks = await olympicsRepository.getOlympicsTasks(token, event.task.olympicsId!);
      emitter(EditOlympicsSuccessfulState(status['message'], event.olympicsPath, false));
      emitter(EditOlympicsDefaultState(olympics, event.olympicsPath, tasks, ''));
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, ''));
    }
  }

  Future<void> _deleteTaskHandler(DeleteTaskEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Удаление задания'));
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.deleteTask(token, event.task.id!);
      final olympics = await olympicsRepository.getOlympicsById(token, event.task.olympicsId!);
      final tasks = await olympicsRepository.getOlympicsTasks(token, event.task.olympicsId!);
      emitter(EditOlympicsSuccessfulState(status['message'], event.olympicsPath, false));
      emitter(EditOlympicsDefaultState(olympics, event.olympicsPath, tasks, ''));
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, ''));
    }
  }

  Future<void> _createTaskHandler(CreateTaskEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Добавление задания'));
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.createTask(token, event.task);
      final olympics = await olympicsRepository.getOlympicsById(token, event.task.olympicsId!);
      final tasks = await olympicsRepository.getOlympicsTasks(token, event.task.olympicsId!);
      emitter(EditOlympicsSuccessfulState(status['message'], event.olympicsPath, false));
      emitter(EditOlympicsDefaultState(olympics, event.olympicsPath, tasks, ''));
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, ''));
    }
  }

  Future<void> _loadOlympicsHandler(LoadOlympicsEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Загрузка'));
      final token = await sharedPrefs.getToken();
      final olympics = await olympicsRepository.getOlympicsById(token, event.olympicsId);
      final tasks = await olympicsRepository.getOlympicsTasks(token, event.olympicsId);
      emitter(EditOlympicsDefaultState(olympics, event.olympicsPath, tasks, ''));
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsEmptyState());
    }
  }

  Future<void> _deleteOlympicsHandler(DeleteOlympicsEvent event, Emitter<EditOlympicsState> emitter) async {
    try{
      emitter(EditOlympicsLoadingState('Удаление'));
      final token = await sharedPrefs.getToken();
      final status = await olympicsRepository.deleteOlympics(token, event.olympics.id!);
      emitter(EditOlympicsSuccessfulState(status['message'], event.olympicsPath, true));
      emitter(EditOlympicsEmptyState());
    }
    catch(error){
      print(error);
      emitter(EditOlympicsErrorState(error.toString()));
      emitter(EditOlympicsDefaultState(event.olympics, event.olympicsPath, event.tasks, ''));
    }
  }
}