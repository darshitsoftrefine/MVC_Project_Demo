abstract class PostGetEvent {}

class PostGetSubmittingEvent extends PostGetEvent {}

class PostGetSubmittedEvent extends PostGetEvent{
  final String loginToken;

  PostGetSubmittedEvent({required this.loginToken});

}