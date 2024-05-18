part of 'chat_user_card_cubit.dart';

@immutable
sealed class ChatUserCardState {}

final class ChatUserCardInitial extends ChatUserCardState {}

final class ChatUserCardLoaded extends ChatUserCardState {
  final Message? message;

  ChatUserCardLoaded(this.message);
}

final class ChatUserCardLoading extends ChatUserCardState {}

final class ChatUserCardError extends ChatUserCardState {
  final String error;

  ChatUserCardError(this.error);
}
