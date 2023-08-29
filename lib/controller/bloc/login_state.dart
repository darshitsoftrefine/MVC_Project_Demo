import 'package:equatable/equatable.dart';
import '../../model/model.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadedState extends LoginState {
  final ContactPerson contDetails;
  LoginLoadedState({
    required this.contDetails,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}