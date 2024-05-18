import '../home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/core/helper/spacing.dart';
import 'package:chatapp/core/constant/color_manger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/auth/login_screen/login_screen.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
    super.initState();
  }

  void checkSignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print('\nUser: ${FirebaseAuth.instance.currentUser}');
      //navigate to home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      //navigate to login screen
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/splash.jpg",
                width: 300.w,
                height: 300.h,
              ),
              verticalSpace(20),
              const Text(
                "World's largest Private Chat App",
                style: TextStyle(color: ColorManger.themeColor),
              ),
              verticalSpace(20),
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(
                    color: ColorManger.themeColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
