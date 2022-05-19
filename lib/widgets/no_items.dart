import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final String message;
  const NoItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
