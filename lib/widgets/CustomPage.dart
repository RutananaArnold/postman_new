// ignore_for_file: file_names, duplicate_ignore, must_be_immutable

import 'package:flutter/material.dart';
import 'package:postman/widgets/bottom-anime.dart';

class CustomPage extends StatefulWidget {
  Widget child;
  Color bgColor;
  FloatingActionButtonLocation floatingActionButtonLocation;
  Widget floatActionButton;
  Widget endDrawer;
  PreferredSizeWidget? appBar;
  Widget? drawer;

  CustomPage({
    Key? key,
    required this.child,
    this.drawer,
    this.endDrawer = const SizedBox(),
    this.appBar,
    this.bgColor = Colors.white,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.floatActionButton = const Text(""),
  }) : super(key: key);

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: 1.6,
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: widget.appBar,
      body: SafeArea(
        child: BottomTopMoveAnimationView(
          animationController: controller,
          child: Stack(children: [
            const SizedBox.expand(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: widget.child,
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: widget.floatActionButton,
      endDrawer: widget.endDrawer,
      drawer: widget.drawer,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
