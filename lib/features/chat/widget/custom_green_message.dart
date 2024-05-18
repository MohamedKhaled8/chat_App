import 'package:flutter/material.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/my_date_util.dart';
import '../../home/data/model/message_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CustomGreenMessge extends StatelessWidget {
    final Message message;

  const CustomGreenMessge({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        var mq = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            horizintalSpace(12),
            if ( message.read.isNotEmpty)
              Icon(Icons.done_all_rounded, color: Colors.blue, size: 20.h),
            horizintalSpace(2),
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time:  message.sent),
              style: TextStyle(fontSize: 13.sp, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all( message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 255, 176),
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child:  message.type == Type.text
                ? Text(
                     message.msg,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl:  message.msg,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
