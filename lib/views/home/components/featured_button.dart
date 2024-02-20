import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/views/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 80,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      Expanded(
          child: title!.text.fontFamily(semibold).color(darkFontGrey).make()),
    ],
  )
      .box
      .white
      .width(200)
      .height(100)
      .padding(EdgeInsets.all(4))
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
