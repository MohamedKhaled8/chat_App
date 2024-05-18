import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../features/home/data/model/chat_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/features/view_profile_screen/view_profile_screen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: mq.width * .6,
          height: mq.height * .35,
          child: Stack(
            children: [
              //user profile picture
              Positioned(
                top: mq.height * .075,
                left: mq.width * .1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .25),
                  child: CachedNetworkImage(
                    width: mq.width * .5,
                    fit: BoxFit.cover,
                    imageUrl: user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
              ),

              //user name
              Positioned(
                left: mq.width * .04,
                top: mq.height * .02,
                width: mq.width * .55,
                child: Text(user.name,
                    style:  TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w500)),
              ),

              //info button
              Positioned(
                  right: 8.w,
                  top: 6.h,
                  child: MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProfileScreen(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0).r,
                    shape: const CircleBorder(),
                    child:  Icon(Icons.info_outline,
                        color: Colors.blue, size: 30.h),
                  ))
            ],
          )),
    );
  }
}
