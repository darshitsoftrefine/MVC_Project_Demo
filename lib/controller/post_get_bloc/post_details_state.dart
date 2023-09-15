import 'package:coupinos_project/model/post_get_data/post_get_model.dart';

import '../../model/post_get_data/post_details_model.dart';

abstract class PostDetailsState  {}

class PostDetailsInitialState extends PostDetailsState {}

class PostDetailsLoadingState extends PostDetailsState {}

class PostDetailsFailureState extends PostDetailsState {}

class PostDetailsSuccessState extends PostDetailsState {
  final Data? postDetails;

  PostDetailsSuccessState({required this.postDetails});
}

