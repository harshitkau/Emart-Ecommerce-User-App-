import 'package:ecommerce/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(icon, color: color)
        .box
        .border(color: color)
        .roundedSM
        .padding(EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      width: 120,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone ? Icon(icon, color: color) : Container()
        ],
      ),
    ),
  );
}
