import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatapp/core/helper/my_date_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ViewProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: Text(widget.user.name)),
        floatingActionButton: //user about
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Joined On: ',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
            Text(
                MyDateUtil.getLastMessageTime(
                    context: context,
                    time: widget.user.createdAt,
                    showYear: true),
                style: TextStyle(color: Colors.black54, fontSize: 15.sp)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // for adding some space
                SizedBox(width: mq.width, height: mq.height * .03),

                //user profile picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .1),
                  child: CachedNetworkImage(
                    width: mq.height * .2,
                    height: mq.height * .2,
                    fit: BoxFit.cover,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),

                // for adding some space
                SizedBox(height: mq.height * .03),

                // user email label
                Text(widget.user.email,
                    style:
                         TextStyle(color: Colors.black87, fontSize: 16.sp)),

                // for adding some space
                SizedBox(height: mq.height * .02),

                //user about
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'About: ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp),
                    ),
                    Text(widget.user.about,
                        style:
                            TextStyle(color: Colors.black54, fontSize: 15.sp)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
