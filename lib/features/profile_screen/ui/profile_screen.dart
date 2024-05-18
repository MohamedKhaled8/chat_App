import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/core/helper/spacing.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';
import '../widgets/custom_text_form_field_display_fata_profile_Screen.dart';
import '../widgets/custom_display_photo_and_upload_photo_profile_screen.dart';
import 'package:chatapp/features/profile_screen/logic/cubit/proifle_cubit.dart';
import 'package:chatapp/features/profile_screen/widgets/custom_floating_action_button_profile_screen.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfileScreen extends StatelessWidget {
  final ChatUser chatUser;
  const ProfileScreen({
    Key? key,
    required this.chatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProfileCubit(chatUser),
      child: BlocBuilder<ProfileCubit, ProifleState>(builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);

        return Scaffold(
          backgroundColor: const Color(0xff182020),
          appBar: AppBar(
            backgroundColor: const Color(0xff182020),
            elevation: 0.0,
            title: const Text(
              "Profile Screen",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          floatingActionButton: CustomFloatingActionButtonProfileScreen(
              profileCubit: profileCubit),
          body: Form(
            key: profileCubit.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpace(50),
                    CustomDisplayAndUploadPhotoProfileScreen(
                        mq: mq, chatUser: chatUser),
                    verticalSpace(20),
                    CUstomTextFormFieldDisplayDataProfileScreen(
                      chatUser: chatUser,
                      initialValue: chatUser.name,
                      onSaved: (val) => FirebaseHelper.me.name = val ?? '',
                      text: "Name",
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                    ),
                    verticalSpace(30),
                    CUstomTextFormFieldDisplayDataProfileScreen(
                      chatUser: chatUser,
                      initialValue: chatUser.about,
                      onSaved: (val) => FirebaseHelper.me.about = val ?? '',
                      text: "about",
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                    ),
                    // verticalSpace(20),
                    // CustomButtonLocal(
                    //   higth: 50,
                    //   title: 'Edite',
                    //   width: 320,
                    //   image: '',
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
