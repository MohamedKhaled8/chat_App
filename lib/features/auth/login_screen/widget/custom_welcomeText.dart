import 'package:flutter/material.dart';
import '../../../../core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/auth/login_screen/logic/cubit/login_cubit.dart';



class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.loginCubit,
  });

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        loginCubit.handelGoogleBtnClick(context);
      },
      child: Container(
        width: 300.w,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              height: 35.h,
            ),
            horizintalSpace(10),
            Text(
              "Sign in With Google",
              style: TextStyle(fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }
}