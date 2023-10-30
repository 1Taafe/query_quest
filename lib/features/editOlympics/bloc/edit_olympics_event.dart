import 'package:query_quest/repositories/models/Olympics.dart';

import '../../../repositories/models/Task.dart';

abstract class EditOlympicsEvent {

}

class LoadOlympicsEvent extends EditOlympicsEvent{
  final int olympicsId;
  final String olympicsPath;
  LoadOlympicsEvent(this.olympicsId, this.olympicsPath);
}

class CreateTaskEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final Task task;
  final List<Task> tasks;
  CreateTaskEvent(this.olympicsPath, this.task, this.tasks, this.olympics);
}

class DeleteTaskEvent extends EditOlympicsEvent{
  final String olympicsPath;
  final Olympics olympics;
  final Task task;
  final List<Task> tasks;
  DeleteTaskEvent(this.olympicsPath, this.task, this.tasks, this.olympics);
}

class DeleteOlympicsEvent extends EditOlympicsEvent{
  final Olympics olympics;
  final String olympicsPath;
  final List<Task> tasks;
  DeleteOlympicsEvent(this.olympics, this.olympicsPath, this.tasks);
}

