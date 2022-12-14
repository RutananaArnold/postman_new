import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// custom libraries
import 'AUTH/login.dart';
import 'screens/Intro.dart';
import 'screens/Offline.dart';
import 'screens/Splash.dart';
import 'screens/Restart.dart';
import 'screens/AddAddress.dart';
import 'screens/index.dart';

void main() {
  runApp(
    RestartWidget(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> execute() async {
    // Simple check to see if we have Internet
    return await InternetConnectionChecker().hasConnection;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // InternetConnectionChecker.DEFAULT_ADDRESSES.add('www.google.com');
    return MaterialApp(
        title: 'Postman Client',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        builder: EasyLoading.init(),
        routes: {
          '/': (context) => Splash(internetChecker: execute()),
          '/offline': (context) => const Offline(),
          '/intro': (context) => const IntroductionScreen(),
          '/login': (context) => const Login(),
          '/index': (context) => const Index(),
          '/add_addres': (context) => const AddAdress(),
        });
  }
}
