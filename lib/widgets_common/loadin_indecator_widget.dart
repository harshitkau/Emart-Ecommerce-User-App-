import 'package:ecommerce/consts/consts.dart';

Widget loadinIndicator() {
  return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(redColor));
}
