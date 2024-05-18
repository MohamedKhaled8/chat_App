import 'package:flutter/material.dart';
import '../../home/data/model/chat_user.dart';

class CUstomTextFormFieldDisplayDataProfileScreen extends StatelessWidget {
  final String initialValue;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String text;
  final ChatUser chatUser;

  const CUstomTextFormFieldDisplayDataProfileScreen({
    Key? key,
    required this.initialValue,
    required this.onSaved,
    required this.validator,
    required this.text,
    required this.chatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      style: const TextStyle(color: Colors.white), // Change text color here
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: 'eg. Happy Singh',
        labelText: text,
        hintStyle: const TextStyle(color: Colors.white),
        labelStyle:
            const TextStyle(color: Colors.white), // Change label color here
      ),
    );
  }
}
