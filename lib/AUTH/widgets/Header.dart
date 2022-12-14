// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:postman/widgets/Space.dart';

class Header extends StatelessWidget {
  String? text;
  Header({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: Image.asset("assets/splash.png"),
        ),
        Space(),
        Text(
          "Postman $text",
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        Space(),
      ],
    );
  }
}
