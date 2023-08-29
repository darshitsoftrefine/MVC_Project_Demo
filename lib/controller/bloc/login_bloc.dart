import 'package:bloc/bloc.dart';
import '../../model/model.dart';
import '../../model/repository.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ContactRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitialState()) {
    on((event, emit) async {
      if(event is LoginSubmittingEvent){
        emit(LoginLoadingState());
      } else if(event is LoginSubmittedEvent){
        try{
          ContactPerson contactDetails = await repository.getContactDetails();
          emit(LoginSuccessState(contactDetails: contactDetails));
          print("Success");
        }catch(e){
          print("Error $e");
          emit(LoginFailureState());
        }
      }
    });
  }
}