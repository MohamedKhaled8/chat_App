import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../logic/cubit/proifle_cubit.dart';
import '../../home/data/model/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/botton_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomDisplayAndUploadPhotoProfileScreen extends StatelessWidget {
  final Size mq;
  final ChatUser chatUser;
  const CustomDisplayAndUploadPhotoProfileScreen({
    super.key,
    required this.mq,
    required this.chatUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(chatUser),
      child: BlocBuilder<ProfileCubit, ProifleState>(
        builder: (context, state) {
          var profileCubit = ProfileCubit.get(context);
          return Stack(
            children: [
              profileCubit.imagee != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: Image.file(File(profileCubit.imagee!),
                          width: mq.height * .2,
                          height: mq.height * .2,
                          fit: BoxFit.cover))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        imageUrl: chatUser.image,
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        ),
                      ),
                    ),
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: MaterialButton(
                  elevation: 1,
                  onPressed: () {
                    showBottomSheetProfile(
                      context,
                    );
                  },
                  shape: const CircleBorder(),
                  color: Colors.white,
                  child: const Icon(Icons.edit, color: Colors.blue),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
