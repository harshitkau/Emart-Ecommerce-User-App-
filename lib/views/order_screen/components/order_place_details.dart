import 'package:ecommerce/consts/consts.dart';

Widget OrderPlaceDetails({title1, detail1, title2, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$detail1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$detail2".text.fontFamily(semibold).make()
            ],
          ),
        )
      ],
    ),
  );
}
