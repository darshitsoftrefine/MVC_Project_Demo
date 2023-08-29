abstract class LoginEvent {}

class LoginSubmittingEvent extends LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({required this.email, required this.password});


}

