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
  final Task task;
  CreateTaskEvent(this.olympicsPath, this.task);
}

class DeleteOlympicsEvent extends EditOlympicsEvent{
  final Olympics olympics;
  final String olympicsPath;
  DeleteOlympicsEvent(this.olympics, this.olympicsPath);
}

