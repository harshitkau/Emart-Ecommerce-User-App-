import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/product_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
    Get.put(ProductController());
  }

  var currentNavIndex = 0.obs;
  var searchController = TextEditingController();

  var username = '';
  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}
