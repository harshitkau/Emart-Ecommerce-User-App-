import 'package:ecommerce/consts/list.dart';
import 'package:ecommerce/consts/strings.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:ecommerce/views/category_screen/category_details.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.white),
        title: category.text.white.fontFamily(bold).make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            mainAxisExtent: 200,
            crossAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Image.asset(
                  categoryImagesList[index],
                  width: 200,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                categoryList[index]
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .fontFamily(semibold)
                    .make()
              ],
            )
                .box
                .rounded
                .white
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              controller.getSubCategory(categoryList[index]);
              Get.to(() => CategoryDetails(title: categoryList[index]));
            });
          },
        ),
      ),
    ));
  }
}
