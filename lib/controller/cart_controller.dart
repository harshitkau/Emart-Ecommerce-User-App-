import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var placingOrder = false.obs;

  // Controller for the shipping text
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  // payment index
  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var product = [];
  var vendors = [];
  calculateCartPrice(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value += int.parse(data[i]['totalprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await getAllVendors();
    await firestore.collection(orderCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postal_code': postalCodeController.text,
      'shipping_method': "Home Delivery",
      'order_placed': true,
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_delivered': false,
      'payment_method': orderPaymentMethod,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(product),
      'vendors': FieldValue.arrayUnion(vendors)
    });
    placingOrder(false);
  }

  getAllVendors() {
    vendors.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      vendors.add(productSnapshot[i]['vendor_id']);
    }
    print(vendors);
  }

  getProductDetails() {
    product.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      product.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'total_price': productSnapshot[i]['totalprice'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
      });
      print(product);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
