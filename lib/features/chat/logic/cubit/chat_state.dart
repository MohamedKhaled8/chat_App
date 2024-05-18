part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}
final class MessageLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatUser> user;

  ChatLoaded(this.user);
}

final class MessageLoaded extends ChatState {
  final List<Message> messages;

  MessageLoaded(this.messages);
}

final class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}
final class MessageError extends ChatState {
  final String error;

  MessageError({required this.error});
}
