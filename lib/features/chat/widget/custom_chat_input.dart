import 'package:flutter/material.dart';
import '../logic/cubit/chat_cubit.dart';
import 'custom_button_send_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';
import '../../../core/widgets/custom_icon_button_upload_photo.dart';

class CustomChatInput extends StatelessWidget {
  final ChatUser user;
  const CustomChatInput({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ChatCubit(user),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var chatCubit = ChatCubit.get(context);

          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: mq.height * .01, horizontal: mq.width * .025),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        CustomIconButtonSendChatScree(
                          user: user,
                          iconData: Icons.emoji_emotions,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            chatCubit.showEmojiReverse();
                          },
                        ),

                        Expanded(
                            child: TextField(
                          controller: chatCubit.textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onTap: () {
                            chatCubit.showEmojiCondictin();
                          },
                          decoration: const InputDecoration(
                              hintText: 'Type Something...',
                              hintStyle: TextStyle(color: Colors.blueAccent),
                              border: InputBorder.none),
                        )),

                        //pick image from gallery button
                        CustomIconButtonSendChatScree(
                          user: user,
                          iconData: Icons.image,
                          onPressed: () {
                            chatCubit.pickImgeMultiImage();
                          },
                        ),

                        CustomIconButtonSendChatScree(
                            user: user,
                            iconData: Icons.camera_alt_rounded,
                            onPressed: () {
                              chatCubit.pickImgeCamera();
                            }),

                        SizedBox(width: mq.width * .02),
                      ],
                    ),
                  ),
                ),

                CustomButtonSendMessage(user: user)
              ],
            ),
          );
        },
      ),
    );
  }
}
