import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:query_quest/features/olympics/task_bloc/task_event.dart';
import 'package:query_quest/features/olympics/task_bloc/task_state.dart';

import '../../../repositories/models/Answer.dart';
import '../../../repositories/models/Task.dart';
import '../../../repositories/olympics/OlympicsRepository.dart';
import '../../../repositories/shared_prefs/shared_preferences.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState>{

  final olympicsRepository = OlympicsRepository();
  final sharedPrefs = SharedPrefs();

  TaskBloc() : super(TaskEmptyState()){
    on<TaskLoadEvent>(_loadTaskHandler);
    on<TaskCheckEvent>(_checkTaskHandler);
  }

  Future<void> _checkTaskHandler(TaskCheckEvent event, Emitter<TaskState> emitter) async {
    try{
      emitter(TaskLoadingState());
      final token = await sharedPrefs.getToken();
      await olympicsRepository.executeQueryAsUser(token, event.taskId, event.query);
      final task = await olympicsRepository.getTaskById(token, event.taskId);
      final answer = await olympicsRepository.getAnswer(token, event.taskId);
      emitter(TaskDefaultState(task, answer, event.taskOrderId));
    }
    catch(error){
      //print(error);
      emitter(TaskErrorState(error.toString()));
      emitter(TaskLoadingState());
      final token = await sharedPrefs.getToken();
      final task = await olympicsRepository.getTaskById(token, event.taskId);
      final answer = await olympicsRepository.getAnswer(token, event.taskId);
      emitter(TaskDefaultState(task, answer, event.taskOrderId));
    }
  }

  Future<void> _loadTaskHandler(TaskLoadEvent event, Emitter<TaskState> emitter) async {
    try{
      emitter(TaskLoadingState());
      final token = await sharedPrefs.getToken();
      final task = await olympicsRepository.getTaskById(token, event.taskId);
      final answer = await olympicsRepository.getAnswer(token, event.taskId);
      emitter(TaskDefaultState(task, answer, event.taskOrderId));
    }
    catch(error){
      print(error);
      emitter(TaskEmptyState());
    }
  }

}