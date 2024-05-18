import 'package:flutter/material.dart';
import '../../../core/helper/dialoge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButtonHomeScreen extends StatelessWidget {
  const CustomFloatingActionButtonHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: FloatingActionButton(
          onPressed: () {
            addChatUserDialog(context);
          },
          child: const Icon(Icons.add_comment_rounded)),
    );
  }
}
