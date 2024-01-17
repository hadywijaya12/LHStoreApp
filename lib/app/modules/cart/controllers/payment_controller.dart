import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lhstore/service/payment_service.dart';
import 'package:lhstore/service/user_service.dart';

class PaymentController extends GetxController {
  //TODO: Implement CartController

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

  // getPaymentLink(total) async {
  //   var data = await PaymentService().createPaymentLink(total);
  //   print(data);
  // }
}
