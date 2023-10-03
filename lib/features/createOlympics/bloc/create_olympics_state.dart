abstract class CreateOlympicsState{

}

class DefaultCreateOlympicsState extends CreateOlympicsState {

}

class LoadingOlympicsState extends CreateOlympicsState {

}

class SuccessfulOlympicsState extends CreateOlympicsState{
  final String status;
  SuccessfulOlympicsState(this.status);
}

class ErrorCreateOlympicsState extends CreateOlympicsState{
  final String status;
  ErrorCreateOlympicsState(this.status);
}