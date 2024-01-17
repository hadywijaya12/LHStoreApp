import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/app/modules/login/views/login_view.dart';
import 'package:lhstore/app/modules/register/views/register_view.dart';
import 'package:lhstore/app/modules/setting/views/edit_profile.dart';
import 'package:lhstore/service/singup_failure.dart';
import 'package:lhstore/service/user_service.dart';

// User? get user {
//   return FirebaseAuth.instance.currentUser;
// }

// bool get isLoggedIn => user != null;

class AuthService extends GetxController {
  static AuthService get instance => Get.find();
  final userService = Get.put(UserService());
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var currentIndex = 0;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginView())
        : Get.offAll(() => home(currentIndex: currentIndex));
  }

  Future<bool> register(
      {required String email,
      required String password,
      user,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {userService.createUser(user, context)});
      return true;
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      final test = '${ex.message}';
      var snackbar = SnackBar(content: Text(test));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return false;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<bool> loginByEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (err) {
      print(err);
      return false;
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();

    Get.off(const LoginView());
  }
}
