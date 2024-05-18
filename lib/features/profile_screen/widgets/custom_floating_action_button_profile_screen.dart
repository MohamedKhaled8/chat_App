import 'package:flutter/material.dart';
import '../logic/cubit/proifle_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomFloatingActionButtonProfileScreen extends StatelessWidget {
  const CustomFloatingActionButtonProfileScreen({
    super.key,
    required this.profileCubit,
  });

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            profileCubit.logOut(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout')),
    );
  }
}