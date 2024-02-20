import 'package:ecommerce/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      title!.text.color(fontGrey).make()
    ],
  )
      .box
      .white
      .roundedSM
      .height(80)
      .shadowSm
      .width(width)
      .padding(EdgeInsets.all(4))
      .make();
}
