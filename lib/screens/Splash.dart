// ignore_for_file: file_names, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:postman/controllers/Globals.dart';
import 'package:postman/widgets/bottom-anime.dart';

import '../widgets/Space.dart';

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  Future<bool> internetChecker;
  Splash({Key? key, required this.internetChecker}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: 1.6,
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controller.addListener(() {});
    executeNextProcess();
  }

  executeNextProcess() async {
    bool checker = await widget.internetChecker;
    String? token = await global.getValue("token");
    // print("Splash token: " + token!);
    // print(token);

    ///checker == true ? '/intro' :
    if (token != null) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(
            context, checker == true ? '/index' : '/offline');
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(
            context, checker == true ? '/intro' : '/offline');
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BottomTopMoveAnimationView(
          child: Center(
            child: Column(
              children: [
                Space(space: 0.2),
                Image.asset("assets/download.png"),
                Space(
                  space: 0.05,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                Space(space: 0.2),
                const Text(
                  " Your Reliable Last Mile Friend",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          animationController: controller,
        ),
      ),
    );
  }
}
