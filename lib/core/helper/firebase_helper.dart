import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/model/chat_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../features/home/data/model/message_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseHelper {
  // تعريف المتغيرات الثابتة لإدارة المصادقة وقاعدة بيانات Firestore و Firebase Storage
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static ChatUser me = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');
  static User get user => auth.currentUser!;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // الحصول على رمز Firebase Cloud Messaging (FCM)
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    // الحصول على الرمز
    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        print('Push Token: $t');
      }
    });
  }

  // إرسال إشعار بوجود رسالة جديدة
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name,
          "body": msg,
          "android_channel_id": "chats"
        },
      };

      // إرسال الإشعار
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAiL6n2kY:APA91bHiJJjR_We1txbCCt2gBC3VAbEUc36FztKqjh9JZZGz4bUhen0tnCHkcIYGu3dezrzZBSIJJQP44g02CLmTrZLriZSK3r4gsXxit0OqhmZ4Rfdmqn7_S9zMwjTFdAUXR3YVhQqo' // استبدال YOUR_SERVER_KEY_HERE بمفتاح الخادم الخاص بك
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  // التحقق مما إذا كان المستخدم موجودًا بالفعل في قاعدة البيانات
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // إضافة مستخدم جديد لقائمة مستخدمي المحادثة
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    print('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      return false;
    }
  }

  // الحصول على بيانات المستخدم الخاصة بنفسك
  static Future<void> getSelfInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((userDoc) async {
      if (userDoc.exists) {
        me = ChatUser.fromJson(userDoc.data()!);
        await getFirebaseMessagingToken();
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // إنشاء مستخدم جديد
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // الحصول على قائمة معرفات المستخدمين الذين تمت محادثتهم بالفعل
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // الحصول على قائمة جميع المستخدمين
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    print('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('id', whereIn: userIds.isEmpty ? [''] : userIds)
        .snapshots();
  }

  // إرسال أول رسالة إلى مستخدم
  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // تحديث معلومات المستخدم
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // تحديث صورة الملف الشخصي للمستخدم
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    print('Extension: $ext');

    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  // الحصول على معلومات محددة للمستخدم
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // تحديث حالة المستخدم (متصل أو غير متصل)
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  // معرفة ID المحادثة باستخدام معرف المستخدم
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // الحصول على جميع الرسائل في محادثة معينة
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // إرسال رسالة جديدة
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  // تحديث حالة قراءة الرسالة
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // الحصول على آخر رسالة في المحادثة
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // إرسال صورة في المحادثة
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last;

    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  // حذف رسالة
  static Future<void> deleteMessage(Message message) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  // تحديث الرسالة
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }
}
