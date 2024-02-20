import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/widgets_common/applogo_widget.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/custom_textfield.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? ischecked = false;
  var controller = Get.put(AuthController());

  // text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Sign Up to $appname".text.fontFamily(bold).white.size(18).make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        ispass: false),
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        ispass: false),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        ispass: false),
                    customTextField(
                        hint: passwordHint,
                        title: retypePass,
                        controller: retypePassController,
                        ispass: true),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: redColor,
                            value: ischecked,
                            activeColor: lightGrey,
                            onChanged: (newValue) {
                              setState(() {
                                ischecked = newValue;
                              });
                            }),
                        5.widthBox,
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey),
                            ),
                            TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey),
                            ),
                            TextSpan(
                              text: termandCondition,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor),
                            ),
                          ])),
                        ),
                      ],
                    ),

                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor))
                        : ourButton(
                                onPress: () async {
                                  if (ischecked != false) {
                                    controller.isloading(true);
                                    try {
                                      controller
                                          .signupMethod(
                                              email: emailController.text,
                                              context: context,
                                              password: passwordController.text)
                                          .then((value) {
                                        return controller.storeUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }).then((value) {
                                        VxToast.show(context, msg: loginSucees);
                                        Get.offAll(() => Home());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isloading(false);
                                    }
                                  }
                                },
                                color: ischecked == true ? redColor : lightGrey,
                                textColor:
                                    ischecked == false ? redColor : whiteColor,
                                title: signup)
                            .box
                            .width(context.width - 70)
                            .make(),
                    10.heightBox,
                    // wrapping with gesture detector of velocity x
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyHaveAnAccount.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        })
                      ],
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),

              // 10.heightBox,
            ]),
          ),
        ),
      ),
    );
  }
}
