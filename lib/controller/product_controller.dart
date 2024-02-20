import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subCat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalprice = 0.obs;

  var isFavorite = false.obs;

  getSubCategory(title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subCat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantity.value;
  }

  addToCart(
      {title,
      img,
      sellername,
      color,
      quantity,
      totalprice,
      context,
      vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'quantity': quantity,
      'vendor_id': vendorId,
      'totalprice': totalprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValue() {
    totalprice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishlist(docsId, context) async {
    await firestore.collection(productsCollection).doc(docsId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFavorite(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeToWishlist(docsId, context) async {
    await firestore.collection(productsCollection).doc(docsId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFavorite(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFavorite(true);
    } else {
      isFavorite(false);
    }
  }
}
