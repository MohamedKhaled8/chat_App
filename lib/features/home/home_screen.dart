import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/features/home/logic/cubit/home_cubit.dart';
import 'package:chatapp/features/home/widget/custom_home_error.dart';
import 'package:chatapp/features/home/widget/custom_home_loaded.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..intializ()
        ..fetchUsers(),
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is HomeInitial || state is HomeLoading) {
          return const CustomHomeLoaded();
        } else if (state is HomeLoaded) {
          return const CustomHomeLoaded();
        } else if (state is HomeError) {
          return CustomHomeError(
            error: state.error,
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
