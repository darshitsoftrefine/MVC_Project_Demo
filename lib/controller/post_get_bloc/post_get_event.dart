abstract class PostGetEvent {}

class PostGetSubmittingEvent extends PostGetEvent {}

class PostGetSubmittedEvent extends PostGetEvent{
  final String loginToken;
  final int radius;
  final double latitude;
  final double longitude;
  final int pageSize;
  final int page;

  PostGetSubmittedEvent({required this.loginToken, required this.radius, required this.latitude, required this.longitude, required this.pageSize, required this.page});

}

//  body calling