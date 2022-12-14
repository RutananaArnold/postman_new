import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  String? label;
  String? value;
  FontWeight fontWeight;
  double padding;
  double textSize;
  double elevation;
  ProfileTile({
    Key? key,
    this.label,
    this.elevation = 1,
    this.textSize = 16,
    this.padding = 10.0,
    this.fontWeight = FontWeight.w500,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size  size = MediaQuery.of(context).size;
    return Card(
      elevation: elevation,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label!,
              style: TextStyle(
                  fontSize: textSize,
                  fontWeight: fontWeight,
                  color: Colors.black),
            ),
            Text(
              value ?? "no data",
              style: TextStyle(
                  fontSize: textSize,
                  fontWeight: fontWeight,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
