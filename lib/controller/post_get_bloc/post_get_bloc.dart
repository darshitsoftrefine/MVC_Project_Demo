import 'package:bloc/bloc.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_get_event.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_get_state.dart';
import 'package:flutter/material.dart';
import '../../model/post_get_data/post_get_model.dart';
import '../../model/post_get_data/post_get_repository.dart';

class PostGetBloc extends Bloc<PostGetEvent, PostGetState> {
  PostRepository repository;

  PostGetBloc({required this.repository}) : super(PostGetInitialState()) {
    on((event, emit) async {
      if(event is PostGetSubmittingEvent){
        emit(PostGetLoadingState());
      } else if(event is PostGetSubmittedEvent){
        try{
          List<Posts> postDetails = (await repository.getPostDetails(10, 0, 0, 72.50369833333333, 23.034296666666666)) as List<Posts>;
          emit(PostGetSuccessState(postDetails: postDetails));
          debugPrint("Success");
        }catch(e){
          debugPrint("Error $e");
          emit(PostGetFailureState());
        }
      }
    });
  }
}