import 'package:flutter/material.dart';
import '../widget/custom_blue_message.dart';
import '../widget/custom_green_message.dart';
import 'package:chatapp/core/helper/botton_sheet.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:chatapp/features/home/data/model/message_model.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseHelper.user.uid == message.fromId;

    return InkWell(
        onLongPress: () {
          showBottomSheetChat(message: message, isMe, context);
        },
        child: isMe
            ? CustomGreenMessge(
                message: message,
              )
            : CustomBlueMessage(message: message));
  }
}
