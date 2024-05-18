import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../home/data/model/chat_user.dart';
import '../../../core/helper/my_date_util.dart';
import 'package:chatapp/core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_profile_screen/view_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomChatLoaded extends StatelessWidget {
  const CustomChatLoaded({
    super.key,
    required this.user,
    required this.userList,
  });

  final ChatUser user;
  final List<ChatUser> userList;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewProfileScreen(
                      user: user,
                    )));
      },
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .03),
            child: CachedNetworkImage(
              width: mq.height * .05,
              height: mq.height * .05,
              imageUrl: userList.isNotEmpty ? userList[0].image : user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          ),
          horizintalSpace(5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userList.isNotEmpty ? userList[0].name : user.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(5),
              Text(
                userList.isNotEmpty
                    ? userList[0].isOnline
                        ? 'Online'
                        : MyDateUtil.getLastActiveTime(
                            context: context,
                            lastActive: userList[0].lastActive)
                    : MyDateUtil.getLastActiveTime(
                        context: context, lastActive: user.lastActive),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
