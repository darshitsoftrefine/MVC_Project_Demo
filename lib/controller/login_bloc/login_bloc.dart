import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../model/login_data/login_model.dart';
import '../../model/login_data/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  CoupinosLogin repository;

  LoginBloc({required this.repository}) : super(LoginInitialState()) {
    on((event, emit) async {
      if(event is LoginSubmittingEvent){
        emit(LoginLoadingState());
      } else if(event is LoginSubmittedEvent){
        try{
          CoupinoModel contactDetails = await repository.getContactDetails(event.email, event.password);
          emit(LoginSuccessState(contactDetails: contactDetails));
          debugPrint("Success");
        }catch(e){
          debugPrint("Error: $e");
          emit(LoginFailureState());
        }
      }
    });
  }
}