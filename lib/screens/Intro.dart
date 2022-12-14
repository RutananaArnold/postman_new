// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
// import 'package:finda/components/Page.dart';
import 'package:flutter/material.dart';
import 'package:postman/AUTH/complete_profile.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/PageView.dart';
import '../widgets/CommonButton.dart';
import '../widgets/CustomPage.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  var pageController = PageController(initialPage: 0);
  late AnimationController bottomAnimationController;
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    bottomAnimationController = AnimationController(
      // value: 50,
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    pageViewModelData.add(
      PageViewData(
        titleText: 'Exclusive care for you',
        subText:
            "Our convinient services enable us deliver your mail to the required destination.",
        assetsImage: "assets/intro.png",
      ),
    );

    // pageViewModelData.add(
    //   PageViewData(
    //     titleText: 'Intelligent Lost & Found Online Mechanism',
    //     subText:
    //         "Searchit is an entirely new intelligent lost and found matching system.",
    //     assetsImage: "assets/demoLogo.png",
    //   ),
    // );

    pageViewModelData.add(PageViewData(
      titleText: 'Timely delivery',
      subText: "We deliver your mail on time",
      assetsImage: "assets/intro2.png",
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width * 0.8,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  double height = 250;

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatActionButton: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: Center(
          child: Column(
            children: [
              SmoothPageIndicator(
                controller: pageController, // PageController
                count: pageViewModelData.length, // total page count
                effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.black38,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0), // your preferred effect
                onDotClicked: (index) {
                  setState(() {
                    currentShowIndex = index;
                  });
                },
              ),
              CommonButton(
                height: 60,
                backgroundColor: Colors.red,
                padding: const EdgeInsets.only(
                    left: 48, right: 48, bottom: 8, top: 32),
                buttonText: "GET STARTED",
                onTap: () =>
                    // Navigator.of(context).push(
                    //       MaterialPageRoute<void>(
                    //         builder: (BuildContext context) => CompleteProfile(),
                    //       ),
                    //     )
                    Navigator.of(context).pushReplacementNamed("/login"),
              ),
            ],
          ),
        ),
      ),
      child: PageView(
        controller: pageController,
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            currentShowIndex = index;
          });
        },
        scrollDirection: Axis.horizontal,
        children: List.generate(
          pageViewModelData.length,
          (index) => PagePopup(imageData: pageViewModelData[index]),
        ),
      ),
    );
  }
}
