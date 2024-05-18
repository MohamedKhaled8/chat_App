import 'package:flutter/material.dart';
import '../logic/cubit/chat_cubit.dart';
import '../../home/data/model/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/firebase_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/home/data/model/message_model.dart';


class CustomButtonSendMessage extends StatelessWidget {
  const CustomButtonSendMessage({
    super.key,
    required this.user,
  });

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
        var chatCubit = context.read<ChatCubit>();

    return MaterialButton(
      onPressed: () {
        if (chatCubit.textController.text.isNotEmpty) {
          if (chatCubit.list.isEmpty) {
            FirebaseHelper.sendFirstMessage(
                user, chatCubit.textController.text, Type.text);
          } else {
            FirebaseHelper.sendMessage(
                user, chatCubit.textController.text, Type.text);
          }
          chatCubit.textController.text = '';
        }
      },
      minWidth: 0,
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 5.w, left: 10.w),
      shape: const CircleBorder(),
      color: Colors.green,
      child: const Icon(Icons.send, color: Colors.white, size: 28),
    );
  }
}