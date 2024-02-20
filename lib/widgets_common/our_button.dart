import 'package:ecommerce/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: color, padding: EdgeInsets.all(12)),
      onPressed: onPress,
      // child: login.text.color(textColor).fontFamily(bold).make()
      child: title!.text.color(textColor).fontFamily(bold).make());
}
