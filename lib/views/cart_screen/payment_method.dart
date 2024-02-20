import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/list.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make()),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(child: loadinIndicator())
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentmethodList[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Place Successfully");

                    Get.offAll(() => Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place Order"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Obx(
            () => Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(paymentmethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor.withOpacity(0.2)
                              : Colors.transparent,
                          width: 3),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          paymentmethodImg[index],
                          width: context.screenWidth / 3,
                          fit: BoxFit.cover,
                        ),
                        20.widthBox,
                        Expanded(
                            child: "${paymentmethodList[index]}"
                                .text
                                .size(20)
                                .make()),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    value: true,
                                    onChanged: (value) {}))
                            : Container(),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
