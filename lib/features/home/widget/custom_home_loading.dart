import 'package:flutter/material.dart';

class CustomHomeLoading extends StatelessWidget {
  const CustomHomeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("We Chat"),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
