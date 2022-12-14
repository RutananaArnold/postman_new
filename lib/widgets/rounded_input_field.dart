import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String label;
  final IconData? mustIcon;
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final Widget? postfixIcon;
  const RoundedInputField(
      {Key? key,
      required this.label,
      this.mustIcon,
      this.controller,
      required this.hintText,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.postfixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: label + "   ",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                children: [
                  WidgetSpan(
                      child: Icon(
                    mustIcon,
                    size: 12,
                    color: Colors.red,
                  ))
                ],
              ),
            ),
          ),
          CupertinoTextField(
            controller: controller,
            placeholder: hintText,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            suffix: postfixIcon,
          )
        ],
      ),
    );
  }
}
