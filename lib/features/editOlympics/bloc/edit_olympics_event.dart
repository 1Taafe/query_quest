import 'package:query_quest/repositories/models/Olympics.dart';

import '../../../repositories/models/Result.dart';
import '../../../repositories/models/Task.dart';

abstract class EditOlympicsEvent {

}

class LoadOlympicsEvent extends EditOlympicsEvent{
  final int olympicsId;
  final String olympicsPath;
  LoadOlympicsEvent(this.olympicsId, this.olympicsPath);
}

class ExecuteQueryEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final List<Task> tasks;
  final String query;
  final List<Result> results;
  ExecuteQueryEvent(this.olympicsPath, this.tasks, this.olympics, this.query, this.results);
}

class CreateTaskEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final Task task;
  final List<Task> tasks;
  final List<Result> results;
  CreateTaskEvent(this.olympicsPath, this.task, this.tasks, this.olympics, this.results);
}

class UpdateTaskEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final Task task;
  final List<Task> tasks;
  final List<Result> results;
  UpdateTaskEvent(this.olympicsPath, this.olympics, this.tasks, this.task, this.results);
}

class DeleteTaskEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final Task task;
  final List<Task> tasks;
  final List<Result> results;
  DeleteTaskEvent(this.olympicsPath, this.task, this.tasks, this.olympics, this.results);
}

class DeleteOlympicsEvent extends EditOlympicsEvent{
  final Olympics olympics;
  final String olympicsPath;
  final List<Task> tasks;
  final List<Result> results;
  DeleteOlympicsEvent(this.olympics, this.olympicsPath, this.tasks, this.results);
}

