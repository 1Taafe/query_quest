abstract class CreateOlympicsState{

}

class DefaultCreateOlympicsState extends CreateOlympicsState {

}

class ErrorCreateOlympicsState extends CreateOlympicsState{
  final String status;
  ErrorCreateOlympicsState(this.status);
}