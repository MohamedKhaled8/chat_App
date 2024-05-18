part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ChatUser> list;
  final List<String> imageList;

  HomeLoaded({
    required this.list,
    required this.imageList,
  });
}

final class HomeError extends HomeState {
  final String error;

  HomeError({ required this.error});
}
