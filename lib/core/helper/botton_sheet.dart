import 'dialoge.dart';
import 'my_date_util.dart';
import 'firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../../features/chat/widget/option_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/home/logic/cubit/home_cubit.dart';
import 'package:chatapp/features/home/data/model/message_model.dart';
import '../../features/profile_screen/logic/cubit/proifle_cubit.dart';

void showBottomSheetChat(bool isMe, BuildContext context,
    {required final Message message}) {
  var mq = MediaQuery.of(context).size;

  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (_) {
        return ListView(
          reverse: true,
          shrinkWrap: true,
          children: [
            //black divider
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(
                  vertical: mq.height * .015, horizontal: mq.width * .4),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8)),
            ),

            message.type == Type.text
                ?
                //copy option
                OptionItem(
                    icon: Icon(Icons.copy_all_rounded,
                        color: Colors.blue, size: 26.h),
                    name: 'Copy Text',
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: message.msg))
                          .then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);

                        Dialogs.showSnackbar(context, 'Text Copied!');
                      });
                    })
                :
                //save option
                OptionItem(
                    icon: Icon(Icons.download_rounded,
                        color: Colors.blue, size: 26.h),
                    name: 'Save Image',
                    onTap: () async {
                      try {
                        await GallerySaver.saveImage(message.msg,
                                albumName: 'We Chat')
                            .then((success) {
                          //for hiding bottom sheet
                          Navigator.pop(context);
                          if (success != null && success) {
                            Dialogs.showSnackbar(
                                context, 'Image Successfully Saved!');
                          }
                        });
                      } catch (e) {
                        print('ErrorWhileSavingImg: $e');
                      }
                    }),

            //separator or divider
            if (isMe)
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

            //edit option
            if (message.type == Type.text && isMe)
              OptionItem(
                  icon: Icon(Icons.edit, color: Colors.blue, size: 26.h),
                  name: 'Edit Message',
                  onTap: () {
                    //for hiding bottom sheet
                    Navigator.pop(context);

                    _showMessageUpdateDialog(context, message: message);
                  }),

            //delete option
            if (isMe)
              OptionItem(
                  icon:
                      Icon(Icons.delete_forever, color: Colors.red, size: 26.h),
                  name: 'Delete Message',
                  onTap: () async {
                    await FirebaseHelper.deleteMessage(message).then((value) {
                      //for hiding bottom sheet
                      Navigator.pop(context);
                    });
                  }),

            //separator or divider
            Divider(
              color: Colors.black54,
              endIndent: mq.width * .04,
              indent: mq.width * .04,
            ),

            //sent time
            OptionItem(
                icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                name:
                    'Sent At: ${MyDateUtil.getMessageTime(context: context, time: message.sent)}',
                onTap: () {}),

            //read time
            OptionItem(
                icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                name: message.read.isEmpty
                    ? 'Read At: Not seen yet'
                    : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: message.read)}',
                onTap: () {}),
          ],
        );
      });
}

void _showMessageUpdateDialog(BuildContext context,
    {required final Message message}) {
  String updatedMsg = message.msg;

  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 20.h, bottom: 10.h),

            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

            //title
            title: Row(
              children: [
                Icon(
                  Icons.message,
                  color: Colors.blue,
                  size: 28.h,
                ),
                const Text(' Update Message')
              ],
            ),

            //content
            content: TextFormField(
              initialValue: updatedMsg,
              maxLines: null,
              onChanged: (value) => updatedMsg = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),

            //actions
            actions: [
              //cancel button
              MaterialButton(
                  onPressed: () {
                    //hide alert dialog
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                  )),

              //update button
              MaterialButton(
                  onPressed: () {
                    //hide alert dialog
                    Navigator.pop(context);
                    FirebaseHelper.updateMessage(message, updatedMsg);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                  ))
            ],
          ));
}

void showBottomSheetProfile(BuildContext context) {
  var mq = MediaQuery.of(context).size;
  var profileCubit = ProfileCubit.get(context);

  showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding:
              EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
          children: [
            Text('Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: mq.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () {
                      profileCubit.pickImageGallary(context);
                     
                    },
                    child: Image.asset('assets/images/add_image.png')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () {
                      profileCubit.pickImageCamera(context);
                    },
                    child: Image.asset('assets/images/camera.png')),
              ],
            )
          ],
        );
      });
}

void showBottomSheetHome(BuildContext context) {
  var mq = MediaQuery.of(context).size;
  var homeCubit = HomeCubit.get(context);

  showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding:
              EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
          children: [
            Text('Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: mq.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () {
                      homeCubit.pickImageGallary(context);
                      // }
                    },
                    child: Image.asset('assets/images/add_image.png')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () {
                      homeCubit.pickImageCamera(context);
                    },
                    child: Image.asset('assets/images/camera.png')),
              ],
            )
          ],
        );
      });
}
