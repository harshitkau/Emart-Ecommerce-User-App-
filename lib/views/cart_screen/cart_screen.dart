import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/cart_screen/shipping_screen.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:ecommerce/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
          width: context.screenWidth - 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => ShippingScreen());
              },
              textColor: whiteColor,
              title: "Proceed to shipping")),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make()),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadinIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculateCartPrice(data);
            controller.productSnapshot = data;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.network(
                              "${data[index]['img']}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['title']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['totalprice']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                "Quantity: ${data[index]['quantity']}"
                                    .text
                                    .make(),
                                Icon(Icons.delete, color: redColor).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              ],
                            ));
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    Obx(
                      () => "${controller.totalP}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make(),
                    ),
                  ],
                )
                    .box
                    .padding(EdgeInsets.all(12))
                    .width(context.screenWidth - 60)
                    .color(lightgolden)
                    .roundedSM
                    .make(),
                10.heightBox,
                // SizedBox(
                //     width: context.screenWidth - 60,
                //     child: ourButton(
                //         color: redColor,
                //         onPress: () {},
                //         textColor: whiteColor,
                //         title: "Proceed to shipping"))
              ]),
            );
          }
        },
      ),
    );
  }
}
