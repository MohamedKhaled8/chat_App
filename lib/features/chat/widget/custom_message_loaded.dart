import '../ui/message_card.dart';
import 'package:flutter/material.dart';
import '../../home/data/model/message_model.dart';



class CustomMessageLoaded extends StatelessWidget {
  final List<Message> messages; 
  const CustomMessageLoaded({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index]; 
          return MessageCard(message: message);
        },
      ),
    );
  }
}
