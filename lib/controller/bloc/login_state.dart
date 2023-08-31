import '../../model/model.dart';

abstract class LoginState  {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailureState extends LoginState {}

class LoginSuccessState extends LoginState {
  final CoupinoModel contactDetails;

  LoginSuccessState({required this.contactDetails});
}

