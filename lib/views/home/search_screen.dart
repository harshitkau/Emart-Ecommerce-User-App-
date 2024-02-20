import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/category_screen/item_details.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  SearchScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.getsearchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadinIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Product Available"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var searchData = snapshot.data!.docs;
            var fileredData = searchData
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            // print(fileredData[0]);
            if (fileredData.isEmpty) {
              return "No Product Available"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 270),
                  children: fileredData
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(fileredData[index]['p_imgs'][0],
                                  width: 150, height: 150, fit: BoxFit.cover),
                              Spacer(),
                              "${fileredData[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${searchData[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .margin(EdgeInsets.symmetric(horizontal: 6))
                              .roundedSM
                              .shadowSm
                              .padding(EdgeInsets.all(8))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(
                                title: "${fileredData[index]['p_name']}",
                                data: fileredData[index]));
                          }))
                      .toList(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
