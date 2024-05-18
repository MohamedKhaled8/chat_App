import 'chat_screen.dart';
import 'package:flutter/material.dart';
import '../widget/custom_fetch_las_message_user_card.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';

class ChatUserCard extends StatelessWidget {
  final ChatUser user;

  const ChatUserCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ChatScreen(user: user)));
      },
      child: CustomFetchLastMessageUserCard(
        mq: mq,
        user: user,
      ),
    );
  }
}
