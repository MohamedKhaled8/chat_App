import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/core/helper/dialoge.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/core/helper/extensions.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  handelGoogleBtnClick(BuildContext context) {
    Dialogs.showProgressBar(context);
    signInWithGoogle(context).then((user) async {
      context.pop();
      if (user != null) {
        print('\nUser : ${user.user}');
        print('\nAdditional User Info: ${user.additionalUserInfo}');
        // if (await FirebaseHelper.userExists()) {
        //   // توجيه المستخدم إلى الـ homeScreen بعد تسجيل الدخول بنجاح

        // }
        // context.pushReplacmentNamed(Routes.homeScreen);

        init(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
      } else {
        await FirebaseHelper.createUser().then((value) {
          init(context);

          Navigator.push(
              context, MaterialPageRoute(builder: (_) =>  HomeScreen()));
        });
      }
    });
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseHelper.auth.signInWithCredential(credential);
    } catch (e) {
      print("/n_signInWithGoogle");
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  void init(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomeScreen()),
      );
    } else {
      print('User is not logged in!');
    }
  }
}
