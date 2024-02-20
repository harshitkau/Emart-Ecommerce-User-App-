import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({super.key});

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  // Creating a method to change screen login page or home page
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Image.asset(icSplashBg, width: 300)),
        20.heightBox,
        appLogoWidget(),
        10.heightBox,
        appname.text.fontFamily(bold).size(22).white.make(),
        5.heightBox,
        appversion.text.white.make(),
        Spacer(),
        credits.text.white.fontFamily(semibold).make(),
        30.heightBox,
      ]),
    );
  }
}
