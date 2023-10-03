abstract class EditOlympicsEvent {

}

class DeleteOlympicsEvent extends EditOlympicsEvent{
  final int olympicsId;
  DeleteOlympicsEvent(this.olympicsId);
}

