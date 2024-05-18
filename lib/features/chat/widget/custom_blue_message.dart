import 'package:flutter/material.dart';
import '../../../core/helper/my_date_util.dart';
import '../../home/data/model/message_model.dart';
import '../../../core/helper/firebase_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomBlueMessage extends StatelessWidget {
  final Message message;

  const CustomBlueMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseHelper.user.uid == message.fromId;
    var mq = MediaQuery.of(context).size;

    if (message.read.isEmpty) {
      FirebaseHelper.updateMessageReadStatus(message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
                message.type == Type.image ? mq.width * .03 : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: message.type == Type.text
                ?
                //show text
                Text(
                    message.msg,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  )
                :
                //show image
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: message.msg,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: CircularProgressIndicator(strokeWidth: 2.w),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        //message time
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(context: context, time: message.sent),
            style: TextStyle(fontSize: 13.sp, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
