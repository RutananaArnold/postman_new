// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  ValueChanged<String?>? selectedValue;
  String? titleText;
  List<String> elements;
  IconData mustIcon;
  String displayText;
  DropDownWidget(
      {Key? key,
      this.selectedValue,
      this.mustIcon = Icons.star,
      required this.elements,
      this.displayText = "",
      this.titleText})
      : super(key: key);
  // String v = "Food";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
          child: RichText(
            text: TextSpan(
              text: "$titleText   ",
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
        SizedBox(
          width: size.width,
          height: size.height / 17,
          // height: 48,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadowColor: Colors.black12.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2,
            ),
            child: DropdownButton<String>(
              value: displayText,
              elevation: 20,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              items: List.generate(
                  elements.length,
                  (index) => DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          elements[index],
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                        ),
                      ),
                      value: elements[index])),
              onChanged: selectedValue ?? (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
