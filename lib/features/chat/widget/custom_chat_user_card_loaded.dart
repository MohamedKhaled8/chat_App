import 'package:flutter/material.dart';
import '../../home/data/model/chat_user.dart';
import 'custom_show_imahe_chat_user_card.dart';
import '../../../core/helper/my_date_util.dart';
import '../../home/data/model/message_model.dart';
import '../../../core/helper/firebase_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomChatUserCardLoaded extends StatelessWidget {
  CustomChatUserCardLoaded({
    super.key,
    required this.user,
    required this.mq,
  });

  final ChatUser user;
  final Size mq;

  Message? _message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomShowImageChatUserCard(user: user, mq: mq),

      title: Text(
        user.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        _message != null
            ? _message!.type == Type.image
                ? 'image'
                : _message!.msg
            : user.about,
        maxLines: 1,
        style: const TextStyle(color: Colors.white),
      ),

      //last message time
      trailing: _message == null
          ? null //show nothing when no message is sent
          : _message!.read.isEmpty &&
                  _message!.fromId != FirebaseHelper.user.uid
              ?
              //show for unread message
              Container(
                  width: 12.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade400,
                      borderRadius: BorderRadius.circular(10)),
                )
              :
              //message sent time
              Text(
                  MyDateUtil.getLastMessageTime(
                      context: context, time: _message!.sent),
                  style: const TextStyle(color: Colors.black54),
                ),
    );
  }
}
