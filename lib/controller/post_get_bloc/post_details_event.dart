abstract class PostDetailsEvent {}

class PostDetailsSubmittingEvent extends PostDetailsEvent {}

class PostDetailsSubmittedEvent extends PostDetailsEvent{
  final String id;
  PostDetailsSubmittedEvent({required this.id});
}