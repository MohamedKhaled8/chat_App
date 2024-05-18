import 'firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/data/model/chat_user.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Dialogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.blue.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }
}

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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),

              //info button
              Positioned(
                  right: 8,
                  top: 6,
                  child: MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => ViewProfileScreen(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ))
            ],
          )),
    );
  }
}

void addChatUserDialog(BuildContext context) {
  String email = '';
  var homeCubit = HomeCubit.get(context);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      contentPadding:
          EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(
            Icons.person_add,
            color: Colors.blue,
            size: 28.h,
          ),
          const Text('  Add User')
        ],
      ),
      content: TextFormField(
        maxLines: null,
        onChanged: (value) =>
            email = value.trim(), // تحديث قيمة المتغير email عند تغيير النص
        decoration: InputDecoration(
            hintText: 'Email Id',
            prefixIcon: const Icon(Icons.email, color: Colors.blue),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
      actions: [
        MaterialButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
            },
            child: Text('Cancel',
                style: TextStyle(color: Colors.blue, fontSize: 16.sp))),
        MaterialButton(
          onPressed: () async {
            Navigator.pop(context); // Close the dialog
            if (email.isNotEmpty) {
              try {
                // Add user here
                bool success = await FirebaseHelper.addChatUser(email);
                if (success) {
                  // User added successfully
                  // Update the list in HomeCubit
                  homeCubit.fetchUsers();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User added successfully')));
                } else {
                  // Error occurred while adding user
                  Dialogs.showSnackbar(context, 'User does not exist!');
                }
              } catch (e) {
                // Error occurred during the operation
                print('Error: $e');
                Dialogs.showSnackbar(context, 'Failed to add user');
              }
            } else {
              // Display a message if no email is entered
              Dialogs.showSnackbar(context, 'Please enter an email');
            }
          },
          child: Text(
            'Add',
            style: TextStyle(color: Colors.blue, fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );
}
