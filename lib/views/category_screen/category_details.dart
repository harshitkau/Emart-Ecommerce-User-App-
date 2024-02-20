import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/category_screen/item_details.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  CategoryDetails({required this.title, super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title)) {
      productMethod = FirestoreServices.getSubCategory(title);
    } else {
      productMethod = FirestoreServices.getProduct(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
                leading:
                    Icon(Icons.arrow_back_ios, color: Colors.white).onTap(() {
                  Get.back();
                }),
                title: widget.title!.text.white.fontFamily(bold).make()),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                          List.generate(controller.subCat.length, (index) {
                        return "${controller.subCat[index]}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .size(13)
                            .makeCentered()
                            .box
                            .white
                            .size(150, 60)
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .make()
                            .onTap(() {
                          switchCategory("${controller.subCat[index]}");
                          setState(() {});
                        });
                      }),
                    ),
                  ),
                  20.heightBox,
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                            child: Center(child: loadinIndicator()));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No products found"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;

                        return Expanded(
                            child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 250,
                          ),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data[index]['p_imgs'][0],
                                    width: 200, height: 150, fit: BoxFit.cover),
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
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
                              controller.checkIfFav(data[index]);
                              Get.to(() => ItemDetails(
                                    title: data[index]['p_name'],
                                    data: data[index],
                                  ));
                            });
                          },
                        ));
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
