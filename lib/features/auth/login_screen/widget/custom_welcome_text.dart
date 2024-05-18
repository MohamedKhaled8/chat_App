import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWelcomeText extends StatelessWidget {
  const CustomWelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 200.h),
        width: 175.w,
        child: Text(
          'Welcome Back To MyApp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
