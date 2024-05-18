import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/model/chat_user.dart';
import '../../../home/data/model/message_model.dart';
import '../../../../core/helper/firebase_helper.dart';

part 'chat_user_card_state.dart';

class ChatUserCardCubit extends Cubit<ChatUserCardState> {
  final ChatUser user;

  ChatUserCardCubit(
    this.user,
  ) : super(ChatUserCardInitial());
  static ChatUserCardCubit get(context) => BlocProvider.of(context);

  void fetchLastMessage() {
    emit(ChatUserCardLoading());
    FirebaseHelper.getLastMessage(user).listen(
      (snapshot) {
        try {
          final data = snapshot.docs;
          final list = data.map((e) => Message.fromJson(e.data())).toList();
          Message? lastMessage = list.isNotEmpty ? list[0] : null;
          emit(ChatUserCardLoaded(lastMessage));
        } catch (e) {
          emit(ChatUserCardError("Error: $e"));
        }
      },
      onError: (error) {
        emit(ChatUserCardError("Stream Error: $error"));
      },
    );
  }
}
