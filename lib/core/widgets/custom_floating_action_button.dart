import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloadtinActionButton extends StatelessWidget {
  const CustomFloadtinActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: FloatingActionButton(
        onPressed: () async {
          await FirebaseHelper.auth.signOut();
          await GoogleSignIn().signOut();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }
}