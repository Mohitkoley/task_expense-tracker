import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  String errorText;

  ErrorScreen({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errorText,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
