import 'custom_message_loaded.dart';
import 'package:flutter/material.dart';
import '../logic/cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';

class CustomGetAllMessageChatScreen extends StatelessWidget {
  final ChatUser user;
  const CustomGetAllMessageChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(user)..getAllMessages(),
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) {
          if (current is MessageLoading ||
              (current is MessageLoaded) ||
              (current is MessageError))
            return true;
          else
            return false;
        },
        builder: (context, state) {
          print("body state ${state}");
          var chatCubit = ChatCubit.get(context);

          if (state is MessageLoading) {
            return const CustomLoadingWidget();
          } else if (state is MessageLoaded) {
            return CustomMessageLoaded(
              messages: state.messages,
            );
          } else if (state is MessageError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
