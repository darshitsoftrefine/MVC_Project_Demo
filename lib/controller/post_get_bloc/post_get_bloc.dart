import 'package:bloc/bloc.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_details_event.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_details_state.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_get_event.dart';
import 'package:coupinos_project/controller/post_get_bloc/post_get_state.dart';
import 'package:coupinos_project/model/post_get_data/post_details_repository.dart';
import 'package:flutter/material.dart';
import '../../model/post_get_data/post_details_model.dart';
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
          List<Posts> postDetails = (await repository.getPostDetails(event.radius, event.pageSize, event.page, event.latitude, event.longitude)) as List<Posts>;
          emit(PostGetSuccessState(postDetails: postDetails));
          debugPrint("Success1");
        }catch(e){
          debugPrint("Error $e");
          emit(PostGetFailureState());
        }
      }
    });
  }
}


//Details Bloc
class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  PostDetailsRepository repository;

  PostDetailsBloc({required this.repository}) : super(PostDetailsInitialState()) {
    on((event, emit) async{
      if(event is PostDetailsSubmittingEvent){
        emit(PostDetailsLoadingState());
      } else if(event is PostDetailsSubmittedEvent){
        try{
          Data? postDetails = (await repository.getPostDetails());
          emit(PostDetailsSuccessState(postDetails: postDetails!));
          debugPrint("Success");
        } catch(e){
          debugPrint("Error $e");
          emit(PostDetailsFailureState());
        }
      }
    });
  }
}