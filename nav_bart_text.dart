import 'package:flutter/material.dart';

class NavBartText extends StatelessWidget {
  final String title;
  const NavBartText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }
}
