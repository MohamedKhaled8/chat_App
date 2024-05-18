import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/model/chat_user.dart';
import 'package:chatapp/core/helper/firebase_helper.dart';
import 'package:chatapp/features/home/data/model/message_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUser user;

  ChatCubit(
    this.user,
  ) : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  List<Message> list = [];
  final TextEditingController textController = TextEditingController();
  bool showEmoji = false, isUploading = false;
  final ImagePicker picker = ImagePicker();
  Future<bool> showEmojii() {
    if (showEmoji) {
      showEmoji = !showEmoji;
      emit(ChatInitial());
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void loadMessages() {
    emit(ChatLoading());
    print("Oneeeeeeeeeeeeeeeeeeeeeeeeee");

    FirebaseHelper.getUserInfo(user).listen((snapshot) {
      if (snapshot != null) {
        final data = snapshot.docs;
        final userList = data.map((e) => ChatUser.fromJson(e.data())).toList();
        list.sort((a, b) => a.sent.compareTo(b.sent));
        emit(ChatLoaded(userList));
        print("Loadddddddddded");
      } else {
        emit(ChatError(error: 'Failed to fetch messages'));
        print("Errorrrrrrr");
      }
    });
  }

  void getAllMessages() {
    emit(MessageLoading());
    print("MessageLoadinggggggggggggggggggggggggggggggggggggggggggggggggggg");

    FirebaseHelper.getAllMessages(user).listen((snapshot) {
      if (snapshot != null) {
        final data = snapshot.docs;
        final userList = data.map((e) => Message.fromJson(e.data())).toList();
        list.sort((a, b) => a.sent.compareTo(b.sent));
        emit(MessageLoaded(userList));
        print("MessageLoadedddddddddddddddd");
// Emit MessageLoaded with the loaded list
      } else {
        emit(MessageError(error: 'Failed to fetch messages'));
        print("Errorrrrrrr");
      }
    });
  }

  void showEmojiReverse() {
    showEmoji = !showEmoji;
    emit(ChatInitial());
  }

  void showEmojiCondictin() {
    if (showEmoji) {
      showEmoji = !showEmoji;
      emit(ChatInitial());
    }
  }

  void isUploadStateT() {
    isUploading = true;
    emit(ChatInitial());
  }

  void isUploadStateF() {
    isUploading = false;
    emit(ChatInitial());
  }

  void pickImgeMultiImage() async {
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 70);

    for (var i in images) {
      isUploadStateT();
      await FirebaseHelper.sendChatImage(user, File(i.path));
      isUploadStateF();
    }
  }

  void pickImgeCamera() async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    if (image != null) {
      isUploadStateT();
      await FirebaseHelper.sendChatImage(user, File(image.path));
      isUploadStateF();
    }
  }
}
