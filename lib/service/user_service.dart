import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/cart/views/order_detail.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/models/user_model.dart';

currentUser() {
  final useraa = FirebaseAuth.instance.currentUser;
  final uid = useraa!.uid;
  return uid;
}

currentEmail() {
  final useraa = FirebaseAuth.instance.currentUser;
  final email = useraa!.email;
  return email;
}

class UserService extends GetxController {
  static UserService get instance => Get.find();
  var currentIndex = 4;
  final _db = FirebaseFirestore.instance;
  var dataA = "";
  allUser() {}

  createUser(UserModel user, BuildContext context) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('Users');
    _db.collection("Users").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        if (user.email == '${docSnapshot.data()['Email']}') {
          const snackbar = SnackBar(content: Text("Email sudah ada!"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } else {
          ref
              .doc(currentUser())
              .set(user.toJson())
              .catchError((error, StackTrace) {
            Get.snackbar("Error", "Ada yang bermasalah, Coba lagi.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent.withOpacity(0.1),
                colorText: Colors.red);
            print(error.toString());
          });
        }
      }
    });

    // await _db
    //     .collection("Users")
    //     .add(user.toJson())
    //     .catchError((error, StackTrace) {
    //   Get.snackbar("Error", "Ada yang bermasalah, Coba lagi.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.redAccent.withOpacity(0.1),
    //       colorText: Colors.red);
    //   print(error.toString());
    // });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // Future<List<UserModel>> allUser() async {
  //   final snapshot = await _db.collection("Users").get();
  //   final userData =
  //       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }

  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // Future<String> uploadImageToStorage(String childName, Uint8List file) async {
  //   Reference ref = _storage.ref().child(childName);
  //   UploadTask uploadTask = ref.putData(file);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // Future<String> untukGambar(Uint8List file) async {
  //   return imageUrl;
  // }

  Future<void> updateUserRecord(
      UserModel user, idd, BuildContext context, namas) async {
    await _db.collection("Users").doc(idd).update(user.toJson());
    var test = "test";
    if (namas == "detail") {
      Get.offAll(orderDetail(tests: test));
    } else {
      Get.offAll(home(currentIndex: currentIndex));
    }

    const snackbar = SnackBar(content: Text("Update berhasil!"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  // Future<void> updateUserRecord(
  //     String nama,
  //     String email,
  //     String password,
  //     String alamat,
  //     String telepon,
  //     String role,
  //     Uint8List file,
  //     idd,
  //     BuildContext context) async {
  //   String imageUrl = await uploadImageToStorage("profileImage", file);
  //   await _db.collection("Users").doc(idd).update({
  //     'Nama': nama,
  //     'Email': email,
  //     'Password': password,
  //     'Alamat': alamat,
  //     'Role': role,
  //     'Telepon': telepon,
  //     'Photo': imageUrl,
  //   });
  //   Get.offAll(home(currentIndex: currentIndex));

  //   const snackbar = SnackBar(content: Text("Update berhasil!"));
  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // }
}
