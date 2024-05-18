import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/core/helper/extensions.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<ChatUser> list = [];
  final List<ChatUser> searchList = [];
  bool isSearching = false;
  String? imagee;
  List<String> imageList = [];

  void intializ() {
    FirebaseHelper.getSelfInfo();
    loadImages(); // Load images when the session starts

    SystemChannels.lifecycle.setMessageHandler((message) {
      print('Message: $message');

      if (FirebaseHelper.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          FirebaseHelper.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseHelper.updateActiveStatus(false);
          saveImages(); // Save images when the user logs out
        }
      }

      return Future.value(message);
    });
  }

  Future<void> loadImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedImages = prefs.getStringList('savedImages');
    if (savedImages != null) {
      imageList = savedImages;
      emit(HomeLoaded(list: list, imageList: imageList));
    }
  }

  Future<void> saveImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedImages', imageList);
  }

  Future<bool> isSearchingType() {
    if (isSearching) {
      isSearching = !isSearching;
      emit(HomeInitial());
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void searchType(String val) {
    searchList.clear(); // Clear the previous search results

    for (var i in list) {
      if (i.name.toLowerCase().contains(val.toLowerCase()) ||
          i.email.toLowerCase().contains(val.toLowerCase())) {
        searchList.add(i);
      }
    }
    emit(HomeLoaded(list: list, imageList: imageList));
  }

  void isSearch() {
    isSearching = !isSearching;
    emit(HomeInitial());
  }

  void clearSearch() {
    searchList.clear();
  }

  void fetchUsers() async {
    try {
      emit(HomeLoading());
      final snapshot = await FirebaseHelper.getMyUsersId().first;
      final userIds = snapshot.docs.map((e) => e.id).toList();
      final usersSnapshot = await FirebaseHelper.getAllUsers(userIds).first;
      final data = usersSnapshot.docs;
      list = data.map((e) => ChatUser.fromJson(e.data())).toList();

      if (list.isNotEmpty) {
        emit(HomeLoaded(list: list, imageList: imageList));
      } else {
        emit(HomeInitial());
      }
    } catch (e) {
      emit(HomeError(error: 'Failed to fetch users'));
    }
  }

  void pickImageGallary(BuildContext context) async {
    emit(HomeLoading());
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image != null) {
        print('Image Path: ${image.path}');
        imagee = image.path;
        saveProfileImageUrl(image.path);
        imageList.add(image.path);
        saveImages();
        emit(HomeInitial());
        context.pop();
      }
      FirebaseHelper.updateProfilePicture(File(imagee!));
    } catch (e) {
      HomeError(error: 'Failed to pick image from Gallary: $e');
    }
  }

  void pickImageCamera(BuildContext context) async {
    emit(HomeLoading());
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        print('Image Path: ${image.path}');
        imagee = image.path;
        saveProfileImageUrl(image.path);
        saveImages();
        emit(HomeInitial());

        // Add the image path to the list
        imageList.add(image.path);

        Navigator.of(context).pop();
      }
      FirebaseHelper.updateProfilePicture(File(imagee!));
    } catch (e) {
      HomeError(error: 'Failed to pick image from camera: $e');
    }
  }

  Future<void> saveProfileImageUrl(String imageUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImageUrl', imageUrl);
    imagee = imageUrl;
    emit(HomeInitial());
  }

  Future<void> loadProfileImageUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? imageUrl = prefs.getString('profileImageUrl');
    if (imageUrl != null) {
      imagee = imageUrl;
      emit(HomeInitial());
    }
  }

  void updateProfileImage(String imageUrl) {
    imagee = imageUrl;
    saveProfileImageUrl(imageUrl);
  }

  void addNewImage(String imagePath) {
    imageList.add(imagePath);
    saveImages();
    emit(HomeLoaded(list: list, imageList: imageList));
  }

  void removeImage(int index) {
    imageList.removeAt(index);
    saveImages();
    emit(HomeLoaded(list: list, imageList: imageList));
  }
}
