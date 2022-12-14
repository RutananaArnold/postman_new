import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:postman/controllers/Globals.dart';
import 'package:postman/screens/Restart.dart';
import 'package:postman/screens/addresses.dart';
import 'package:postman/screens/help_and_feedback.dart';
import 'package:postman/screens/packages.dart';
import 'package:postman/screens/profile.dart';
import 'package:postman/widgets/drawer_tile.dart';

import 'home.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final ZoomDrawerController z = ZoomDrawerController();

  int counter = 0;
  bool draweropen = false;
  void openCloseDrawer(bool x) {
    // ignore: unrelated_type_equality_checks
    if (x == true) {
      z.close!();
    } else {
      z.open!();
    }
  }

  closeOpenDrawer() {
    if (z.isOpen!() == true) {
      z.close!();
    } else {
      z.open!();
    }
  }

  var titles = [
    'PostMan',
    'Profile',
    'Packages',
    'Addresses',
    'Help & Feedback',
  ];

  List<Widget> tabs = [
    const Home(),
    const Profile(),
    const Packages(),
    const Addresses(),
    const HelpAndFeedback()
  ];

  List<Widget> trailIcon = [
    const Icon(Icons.add, color: Colors.transparent),
    const Icon(Icons.add, color: Colors.transparent),
    const Icon(Icons.add, color: Colors.transparent),
    const Icon(Icons.add, color: Colors.white),
    const Icon(Icons.add, color: Colors.transparent),
  ];

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: ZoomDrawer(
        controller: z,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        showShadow: true,
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        duration: const Duration(milliseconds: 500),
        angle: 0.0,
        menuScreenTapClose: true,
        mainScreenTapClose: true,
        menuScreen: buildDrawer(),
        mainScreen: buildBody(),
      ),
    );
  }

  Widget buildDrawer() {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 17,
            horizontal: MediaQuery.of(context).size.width / 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.greenAccent[200],
                    backgroundImage: const AssetImage("assets/download.png"),
                  ),
                  accountName: const Text(
                    "Bruce",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  accountEmail: const Text("postman@gmail.com"),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              DrawerListTile(
                color: Colors.white,
                title: "Home",
                svgSrc: Icons.home_filled,
                press: () {
                  z.close!();
                  setState(() {
                    currentTabIndex = 0;
                    draweropen = true;
                    openCloseDrawer(draweropen);
                  });

                  // openCloseDrawer();
                },
              ),
              DrawerListTile(
                color: Colors.white,
                title: "My Profile",
                svgSrc: Icons.person,
                press: () {
                  setState(() {
                    currentTabIndex = 1;
                    draweropen = true;
                    openCloseDrawer(draweropen);
                  });
                  // openCloseDrawer();
                },
              ),
              DrawerListTile(
                color: Colors.white,
                title: "Packages",
                svgSrc: Icons.shopping_bag_sharp,
                press: () {
                  setState(() {
                    currentTabIndex = 2;
                    draweropen = true;
                    openCloseDrawer(draweropen);
                  });
                  // openCloseDrawer();
                },
              ),
              DrawerListTile(
                color: Colors.white,
                title: "Addresses",
                svgSrc: Icons.location_on_outlined,
                press: () {
                  setState(() {
                    currentTabIndex = 3;
                    draweropen = true;
                    openCloseDrawer(draweropen);
                  });
                  // openCloseDrawer();
                },
              ),
              DrawerListTile(
                color: Colors.white,
                title: "Help and Feedback",
                svgSrc: Icons.feedback_outlined,
                press: () {
                  setState(() {
                    currentTabIndex = 4;
                    draweropen = true;
                    openCloseDrawer(draweropen);
                  });
                  // openCloseDrawer();
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: DrawerListTile(
                  color: Colors.white,
                  title: "Log Out",
                  svgSrc: Icons.outbond,
                  press: () {
                    global.setValue("token", "");
                    draweropen = true;
                    openCloseDrawer(draweropen);
                    RestartWidget.restartApp(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Scaffold(
      // build your appBar
      appBar: CupertinoNavigationBar(
        leading: CupertinoButton(
            padding: const EdgeInsets.all(5),
            onPressed: () {
              closeOpenDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            )),
        backgroundColor: Colors.red,
        middle: Text(
          titles[currentTabIndex],
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed("/add_addres"),
            child: trailIcon[currentTabIndex]),
      ),

      // build your screen body
      body: tabs[currentTabIndex],
    );
  }
}
