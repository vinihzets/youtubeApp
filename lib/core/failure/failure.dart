abstract class Failure {
  String message;

  Failure({required this.message});
}

class RemoteFailure extends Failure {
  RemoteFailure({required super.message});
}
