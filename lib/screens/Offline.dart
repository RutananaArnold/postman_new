// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:postman/screens/Restart.dart';
import 'package:postman/widgets/CommonButton.dart';

import '../widgets/CustomPage.dart';
import '../widgets/Space.dart';

class Offline extends StatelessWidget {
  const Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomPage(
      child: Column(
        children: [
          Space(
            space: 0.2,
          ),
          Center(
            child: Image.asset("assets/offline.png",
                width: size.width, height: size.height / 3),
          ),
          Space(),
          const Text("You are offline",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
          const Text("Ooops!!!!,Please turn on your internet",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: CommonButton(
                height: 58,
                buttonText: "Reload",
                onTap: () => RestartWidget.restartApp(context),
              ),
            ),
          ),
          // Center(
          //   child: RoundedButton(
          //       text: "Reload",
          //       press: () => RestartWidget.restartApp(context),
          //       color: Colors.red),
          // ),
        ],
      ),
    );
  }
}
