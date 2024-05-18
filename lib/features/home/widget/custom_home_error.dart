import 'package:flutter/material.dart';

class CustomHomeError extends StatelessWidget {
  final String error;
  const CustomHomeError({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('We Chat'),
      ),
      body: Center(
        child: Text(error),
      ),
    );
  }
}