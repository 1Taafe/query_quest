import 'package:query_quest/repositories/models/Olympics.dart';

abstract class CreateOlympicsEvent{

}

class CreateCurrentOlympicsEvent extends CreateOlympicsEvent{
  final Olympics olympics;

  CreateCurrentOlympicsEvent(this.olympics);
}