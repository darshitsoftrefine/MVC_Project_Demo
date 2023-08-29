import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
class FetchLoginEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}