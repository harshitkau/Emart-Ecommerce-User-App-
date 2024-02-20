import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/views/cart_screen/payment_method.dart';
import 'package:ecommerce/widgets_common/custom_textfield.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Shipping Info"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make()),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              onPress: () {
                if (controller.addressController.text.length > 10) {
                  Get.to(() => PaymentMethod());
                } else {
                  VxToast.show(context, msg: "Please Enter the valid address");
                }
              },
              color: redColor,
              textColor: whiteColor,
              title: "Continue"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                customTextField(
                    hint: "Address",
                    ispass: false,
                    title: "Address",
                    controller: controller.addressController),
                customTextField(
                    hint: "City",
                    ispass: false,
                    title: "City",
                    controller: controller.cityController),
                customTextField(
                    hint: "State",
                    ispass: false,
                    title: "State",
                    controller: controller.stateController),
                customTextField(
                    hint: "Postal Code",
                    ispass: false,
                    title: "Postal Code",
                    controller: controller.postalCodeController),
                customTextField(
                    hint: "Phone",
                    ispass: false,
                    title: "Phone",
                    controller: controller.phoneController),
              ],
            ),
          ),
        ));
  }
}
