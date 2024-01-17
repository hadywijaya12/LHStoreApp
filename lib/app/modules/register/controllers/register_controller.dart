import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/models/user_model.dart';
import 'package:lhstore/service/auth_service.dart';
import 'package:lhstore/service/user_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final count = 0.obs;

  final userService = Get.put(UserService());
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
  String? nama;
  String? email;
  String? password;

  // Future<void> createUser(UserModel user) async {
  //   await userService.createUser(user);
  //   return;
  // }

  // void registerUser(String email, String password) {
  //   AuthService.instance.register(email: email, password: password);
  // }

  void register(BuildContext context, user) async {
    // if (email == null && password == null) {
    //   const snackbar = SnackBar(
    //     content: Text("Email dan password harap diisi!"),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   return;
    // }
    // if (email == null) {
    //   const snackbar = SnackBar(
    //     content: Text("Email harap diisi!"),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   return;
    // }
    // if (password == null) {
    //   const snackbar = SnackBar(
    //     content: Text("Password harap diisi!"),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   return;
    // }

    // if (password!.length < 6) {
    //   const snackbar = SnackBar(
    //     content: Text("Password minimal 6 karakter!"),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   return;
    // }

    bool isLoggedIn = await AuthService().register(
        email: email!, password: password!, user: user, context: context);

    if (!isLoggedIn) {
      const snackbar = SnackBar(content: Text("Gagal register!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    Get.offAll(home(currentIndex: currentIndex));
  }
}
