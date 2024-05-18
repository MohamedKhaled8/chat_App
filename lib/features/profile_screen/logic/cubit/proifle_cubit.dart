import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/dialoge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../home/data/model/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/core/helper/extensions.dart';
import '../../../../core/helper/firebase_helper.dart';
import 'package:chatapp/features/auth/login_screen/login_screen.dart';

part 'proifle_state.dart';

class ProfileCubit extends Cubit<ProifleState> {
  final ChatUser user;
  ProfileCubit(
    this.user,
  ) : super(ProifleInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  String? imagee;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void logOut(BuildContext context) async {
    Dialogs.showProgressBar(context);
    emit(ProfileLoading());
    try {
      await FirebaseHelper.updateActiveStatus(false);

      await FirebaseHelper.auth.signOut().then((value) async {
        await GoogleSignIn().signOut().then((value) {
          //for hiding progress dialog
          context.pop();

          context.pop();

          FirebaseHelper.auth = FirebaseAuth.instance;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
        });
      });
    } catch (e) {
      emit(ProifleError(error: 'Failed LogOut'));
    }
  }

  void pickImageGallary(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final ImagePicker picker = ImagePicker();

      // // Pick an image
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image != null) {
        print('Image Path: ${image.path}');
        imagee = image.path;
        emit(ProifleInitial());
        context.pop();
      }
      FirebaseHelper.updateProfilePicture(File(imagee!));
      //   // for hiding bottom sheet
    } catch (e) {
      ProifleError(error: 'Failed to pick image from Gallary: $e');
    }
  }

  void pickImageCamera(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        print('Image Path: ${image.path}');
        if (image != null) {
          imagee = image.path;
          emit(ProifleInitial());
        }

        context.pop();
      }
      FirebaseHelper.updateProfilePicture(File(imagee!));
    } catch (e) {
      ProifleError(error: 'Failed to pick image from camera: $e');
    }
  }
}
