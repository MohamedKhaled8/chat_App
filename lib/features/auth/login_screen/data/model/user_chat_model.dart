import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/core/constant/firebase_constant.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserChatModel {
  final String id;
  final String photoUrl;
  final String nickname;
  final String aboutMe;
  final String phoneNumber;
  UserChatModel({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.aboutMe,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      FireStoreConstant.nickname: nickname,
      FireStoreConstant.aboutMe: aboutMe,
      FireStoreConstant.photoUrl: photoUrl,
      FireStoreConstant.photoNumber: phoneNumber,
    };
  }

  factory UserChatModel.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    try {
      aboutMe = doc.get(FireStoreConstant.aboutMe);
    // ignore: empty_catches
    } catch (e) {}
    try {
      photoUrl = doc.get(FireStoreConstant.photoUrl);
    // ignore: empty_catches
    } catch (e) {}
    try {} catch (e) {
      phoneNumber = doc.get(FireStoreConstant.photoNumber);
    }
    return UserChatModel(
        id: doc.id,
        photoUrl: photoUrl,
        nickname: nickname,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber);
  }
}
