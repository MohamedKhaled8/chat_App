import 'custom_chat_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../logic/cubit/chat_cubit.dart';
import '../../home/data/model/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_loading_widget.dart';

class CustomLoadMessageChatScrren extends StatelessWidget {
  const CustomLoadMessageChatScrren({
    super.key,
    required this.user,
    required this.mq,
  });

  final ChatUser user;
  final Size mq;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(user)..loadMessages(),
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) {
          if (current is ChatLoading ||
              (current is ChatLoaded) ||
              (current is ChatError)) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          var chatCubit = ChatCubit.get(context);

          print("appBar state ${state}==> ${(state is ChatLoaded)}");
          if (state is ChatLoading) {
            return const CustomLoadingWidget();
          } else if (state is ChatLoaded) {
            final userList = state.user;
            return CustomChatLoaded(user: user, userList: userList);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
