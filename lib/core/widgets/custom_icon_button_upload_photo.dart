import 'package:flutter/material.dart';
import '../../features/home/data/model/chat_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButtonSendChatScree extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPressed;
  const CustomIconButtonSendChatScree({
    Key? key,
    required this.iconData,
    this.onPressed,
    required this.user,
  }) : super(key: key);

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(iconData, color: Colors.blueAccent, size: 26.h));
  }
}
