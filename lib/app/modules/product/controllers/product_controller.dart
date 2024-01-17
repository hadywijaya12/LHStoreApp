import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lhstore/models/product_model.dart';
import 'package:lhstore/service/product_service.dart';
import 'package:lhstore/service/user_service.dart';

class ProductController extends GetxController {
  //TODO: Implement ProductController

  var totalPrice = 0.obs;
  var quantity = 0.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  decreaseQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  increaseQuantity(totalQuantity) {
    if (totalQuantity - int.parse(quantity.toString()) < 1) return;
    quantity++;
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({
    idProduct,
    photo,
    nama,
    quantity,
    harga,
    tprice,
  }) async {
    await FirebaseFirestore.instance.collection("Cart").doc().set({
      'idProduct': idProduct,
      'Photo': photo,
      'Nama': nama,
      'Quantity': quantity,
      'Harga': int.parse(harga),
      'Tprice': tprice,
      'added_by': currentUser()
    }).catchError((error) {
      print(error.toString());
    });
  }

  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
  }

  updateStok(quantity, nama, stok, title) {
    var quantityBaru =
        int.parse(stok.toString()) - int.parse(quantity.toString());
    print(int.parse(quantityBaru.toString()));
    try {
      FirebaseFirestore.instance
          .collection("Products")
          .doc(title)
          .update({"Stok": quantityBaru});
    } on Exception catch (err) {
      print(err);
    }
  }
}
