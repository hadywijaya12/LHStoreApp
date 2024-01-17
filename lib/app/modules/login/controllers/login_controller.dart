import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/service/auth_service.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

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
  var currentIndex = 0;
  String? email;
  String? password;
  void login(BuildContext context) async {
    if (email == null && password == null) {
      const snackbar = SnackBar(
        content: Text("Email dan password harap diisi!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    if (email == null) {
      const snackbar = SnackBar(
        content: Text("Email harap diisi!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    if (password == null) {
      const snackbar = SnackBar(
        content: Text("Password harap diisi!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    bool isLoggedIn =
        await AuthService().loginByEmail(email: email!, password: password!);
    if (isLoggedIn == false) {
      const snackbar = SnackBar(
        content: Text("Email atau password anda salah!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    if (isLoggedIn) {
      Get.offAll(home(currentIndex: currentIndex));
    }
  }
}
