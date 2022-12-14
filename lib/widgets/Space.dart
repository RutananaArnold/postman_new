// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  double space;
  Space({Key? key, this.space = 0.03}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * space);
  }
}
