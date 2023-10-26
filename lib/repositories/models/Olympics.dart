import 'User.dart';

class Olympics{
  int? id;
  int? creatorId;
  String? name;
  String? description;
  String? startTime;
  String? endTime;
  String? databaseScript;
  String? databaseName;
  String? image;
  DateTime? startDateTime;
  DateTime? endDateTime;
  User? creator;

  Olympics(
      this.id,
      this.creatorId,
      this.name,
      this.description,
      this.startTime,
      this.endTime,
      this.databaseScript,
      this.databaseName,
      this.image
      ){
    startDateTime = DateTime.tryParse(startTime!);
    endDateTime = DateTime.tryParse(endTime!);
  }

  String getFormattedStartDate(){
    return "${startDateTime?.day.toString().padLeft(2, '0')}.${startDateTime?.month.toString().padLeft(2, '0')}.${startDateTime?.year} ${startDateTime?.hour.toString().padLeft(2, '0')}:${startDateTime?.minute.toString().padLeft(2, '0')}";
  }

  String getFormattedEndDate(){
    return "${endDateTime?.day.toString().padLeft(2, '0')}.${endDateTime?.month.toString().padLeft(2, '0')}.${endDateTime?.year} ${endDateTime?.hour.toString().padLeft(2, '0')}:${endDateTime?.minute.toString().padLeft(2, '0')}";
  }

  Olympics.empty();
}