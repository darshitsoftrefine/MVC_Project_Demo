import 'package:bloc/bloc.dart';
import '../../model/model.dart';
import '../../model/repository.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ContactRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitialState()) {
    on((event, emit) async {
      if(event is FetchLoginEvent) {
        ContactPerson contDetails = await repository.getContactDetails();
        emit(LoginLoadedState(contDetails: contDetails));
      }
      else if(event is LoginErrorState){
        emit(LoginErrorState(message: "Error"));
      }
    });
  }

  LoginState get initialState => LoginInitialState();

}