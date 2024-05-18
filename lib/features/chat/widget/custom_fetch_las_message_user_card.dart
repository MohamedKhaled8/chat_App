import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'custom_chat_user_card_loaded.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/chat_user_card_cubit.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import 'package:chatapp/features/home/data/model/chat_user.dart';

class CustomFetchLastMessageUserCard extends StatelessWidget {
  final ChatUser user;

  const CustomFetchLastMessageUserCard({
    Key? key,
    required this.user,
    required this.mq,
  }) : super(key: key);

  final Size mq;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatUserCardCubit(user)..fetchLastMessage(),
      child: BlocBuilder<ChatUserCardCubit, ChatUserCardState>(
          builder: (context, state) {
        var chatUserCard = ChatUserCardCubit.get(context);

        if (state is ChatUserCardLoading) {
          return const CustomLoadingWidget();
        } else if (state is ChatUserCardLoaded) {
          return CustomChatUserCardLoaded(
            user: user,
            mq: mq,
          );
        } else {
          return const CustomLoadingWidget();
        }
      }),
    );
  }
}
