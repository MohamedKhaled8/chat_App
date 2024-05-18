import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';
import 'package:chatapp/features/chat/logic/cubit/chat_cubit.dart';
import 'package:chatapp/features/chat/widget/custom_chat_input.dart';
import 'package:chatapp/features/chat/widget/custom_load_message_chat_screen.dart';
import 'package:chatapp/features/chat/widget/custom_get_all_message_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  final ChatUser user;
  const ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ChatCubit(user),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var chatCubit = ChatCubit.get(context);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: WillPopScope(
                onWillPop: () {
                  return chatCubit.showEmojii();
                },
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(255, 234, 248, 255),
                  body: Column(
                    children: [
                      verticalSpace(5),
                      CustomLoadMessageChatScrren(user: user, mq: mq),
                      CustomGetAllMessageChatScreen(
                        user: user,
                      ),
                      if (chatCubit.isUploading)
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 20.w),
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2))),
                      CustomChatInput(
                        user: user,
                      ),
                      if (chatCubit.showEmoji)
                        SizedBox(
                          height: mq.height * .35,
                          child: EmojiPicker(
                            textEditingController: chatCubit.textController,
                            config: Config(
                              bgColor: const Color.fromARGB(255, 234, 248, 255),
                              columns: 8,
                              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
