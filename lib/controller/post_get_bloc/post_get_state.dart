import 'package:coupinos_project/model/post_get_data/post_get_model.dart';

abstract class PostGetState  {}

class PostGetInitialState extends PostGetState {}

class PostGetLoadingState extends PostGetState {}

class PostGetFailureState extends PostGetState {}

class PostGetSuccessState extends PostGetState {
  final List<Posts> postDetails;

  PostGetSuccessState({required this.postDetails});
}

