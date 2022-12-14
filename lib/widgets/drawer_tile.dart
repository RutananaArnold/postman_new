import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.color,
  }) : super(key: key);

  final String title;
  final IconData svgSrc;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        svgSrc,
        color: Colors.black,
        size: MediaQuery.of(context).size.height / 40,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: color, fontSize: 10.5, fontWeight: FontWeight.bold),
      ),
    );
  }
}
