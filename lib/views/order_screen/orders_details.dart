import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/views/order_screen/components/order_place_details.dart';
import 'package:ecommerce/views/order_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Order Details".text.fontFamily(semibold).make(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Order Placed",
                showDone: data['order_placed'],
              ),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirm",
                  showDone: data['order_confirmed']),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.delivery_dining_sharp,
                title: "On Delivery",
                showDone: data['order_on_delivery'],
              ),
              orderStatus(
                color: Colors.green,
                icon: Icons.done_all_rounded,
                title: "Delivered",
                showDone: data['order_delivered'],
              ),
              // Divider(),
              10.heightBox,
              Column(
                children: [
                  OrderPlaceDetails(
                      title1: "Order Code",
                      detail1: data['order_code'],
                      title2: "Shipping Method",
                      detail2: data['shipping_method']),
                  OrderPlaceDetails(
                      title1: "Order Date",
                      detail1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      title2: "Payment Method",
                      detail2: data['payment_method']),
                  OrderPlaceDetails(
                      title1: "Payment Status",
                      detail1: "Unpaid",
                      title2: "Delivery Status",
                      detail2: "Order Placed"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.screenWidth - 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_email']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_address']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_city']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_state']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_phone']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                              "${data['order_by_postal_code']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey.withOpacity(0.7))
                                  .make(),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                "${data['total_amount']}"
                                    .numCurrency
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),

              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),

              10.heightBox,
              ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          detail1:
                              "Quantity: ${data['orders'][index]['quantity']}",
                          title2: data['orders'][index]['total_price'],
                          detail2:
                              "Quantity: ${data['orders'][index]['quantity']}",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                              width: 30,
                              height: 20,
                              color: Color(data['orders'][index]['color'])),
                        ),
                        Divider(),
                      ],
                    );
                  })).box.outerShadowMd.white.make(),

              30.heightBox,
            ],
          ),
        ));
  }
}
