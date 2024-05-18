import 'package:chatapp/chat_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  runApp(const ChatApp());
}
