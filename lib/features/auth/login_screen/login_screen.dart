import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/background_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/auth/login_screen/logic/cubit/login_cubit.dart';
import 'package:chatapp/features/auth/login_screen/widget/custom_welcomeText.dart';
import 'package:chatapp/features/auth/login_screen/widget/custom_welcome_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              var loginCubit = LoginCubit.get(context);
              return Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: BackgroundPainter(),
                  ),
                  Positioned(
                    top: 20.h,
                    left: 20.w,
                    child: const CustomWelcomeText(),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    child: CustomButtonAuth(loginCubit: loginCubit),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
