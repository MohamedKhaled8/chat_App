part of 'proifle_cubit.dart';

@immutable
sealed class ProifleState {}

final class ProifleInitial extends ProifleState {}

final class ProifleLoaded extends ProifleState {
  final List<ChatUser> user;

  ProifleLoaded(this.user);
}

final class ProfileLoading extends ProifleState {}

final class ProifleError extends ProifleState {
  final String error;

  ProifleError({required this.error});
}
