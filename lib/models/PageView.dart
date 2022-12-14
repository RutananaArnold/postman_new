import 'package:flutter/material.dart';
import '../widgets/Space.dart';

class PagePopup extends StatelessWidget {
  final PageViewData imageData;

  const PagePopup({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Space(space: 0.001),
          Image.asset(imageData.assetsImage, height: size.height * 0.5),
          // Space(),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                imageData.titleText,
                textScaleFactor: 1.2,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 10, bottom: 4),
              child: Text(
                imageData.subText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // const Expanded(
          //   flex: 1,
          //   child: SizedBox(),
          // ),
        ],
      ),
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetsImage;

  PageViewData({
    required this.titleText,
    required this.subText,
    required this.assetsImage,
  });
}
