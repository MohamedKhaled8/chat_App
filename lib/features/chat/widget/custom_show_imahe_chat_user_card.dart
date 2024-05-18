import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/helper/dialoge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';


class CustomShowImageChatUserCard extends StatelessWidget {
  const CustomShowImageChatUserCard({
    super.key,
    required this.user,
    required this.mq,
  });

  final ChatUser user;
  final Size mq;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => ProfileDialog(user: user));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(mq.height * .03),
        child: CachedNetworkImage(
          width: mq.height * .055,
          height: mq.height * .055,
          imageUrl: user.image,
          errorWidget: (context, url, error) =>
              const CircleAvatar(child: Icon(CupertinoIcons.person)),
        ),
      ),
    );
  }
}
