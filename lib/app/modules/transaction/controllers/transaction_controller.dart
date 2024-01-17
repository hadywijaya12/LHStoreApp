import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lhstore/service/user_service.dart';

class TransactionController extends GetxController {
  //TODO: Implement TransactionController

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

  getAllOrders() {
    return FirebaseFirestore.instance
        .collection("Orders")
        .where("Order_by", isEqualTo: currentUser())
        .snapshots();
  }
}
