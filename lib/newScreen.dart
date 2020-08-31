import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(payload),
      ),
    );
  }
}
