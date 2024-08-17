import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  final String message;
  final String password;
  const HomeAdmin({Key? key, required this.message,required this.password}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        Text(password)
      ],
    );
  }
}
