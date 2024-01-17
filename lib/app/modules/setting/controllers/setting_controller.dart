import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/login/views/login_view.dart';
import 'package:lhstore/models/user_model.dart';
import 'package:lhstore/service/auth_service.dart';
import 'package:lhstore/service/user_service.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController
  static SettingController get instance => Get.find();

  final _authRepo = Get.put(AuthService());
  final _userRepo = Get.put(UserService());
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
  // final nama = TextEditingController();
  // final email = TextEditingController();
  // final telepon = TextEditingController();
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateRecord(UserModel user, idd, BuildContext context, namas) async {
    await _userRepo.updateUserRecord(user, idd, context, namas);
  }

  logout() async {
    await AuthService().logout();
  }

  // getUserData() {
  //   final email = _authservice.firebaseUser.value?.email;

  //   if (email != null) {
  //     return _userservice.getUserDetails(email);
  //   } else {
  //     Get.snackbar("error", "Login to continue");
  //   }
  // }
}
