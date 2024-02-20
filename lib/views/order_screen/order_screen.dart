import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/order_screen/orders_details.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadinIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders Available"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}".text.xl.make(),
                  title: Row(
                    children: [
                      Image.network(
                        data[index]['orders'][0]['img'],
                        width: 50,
                      ),
                      10.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data[index]['orders'][0]['title']
                              .toString()
                              .text
                              .size(18)
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          data[index]['total_amount']
                              .toString()
                              .numCurrency
                              .text
                              .size(12)
                              .fontFamily(bold)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetails(
                            data: data[index],
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: darkFontGrey,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
