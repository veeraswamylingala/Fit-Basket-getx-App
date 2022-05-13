import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/onboarding/onboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FITBASKET',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: SplashScreenView());
  }
}

//Splash Screen

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Get.to(OnbordingPage2(), transition: Transition.leftToRight));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                          "assets/images/strawberrybeveragehealthmilkshake-removebg-preview.png"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "FIT BASKET",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )));
  }
}
