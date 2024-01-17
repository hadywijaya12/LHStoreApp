import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? documentID;
  final String? nama;
  final String? email;
  final String? password;
  final String? alamat;
  final String? telepon;
  final String? role;
  final String? photo;

  const UserModel(
      {this.documentID,
      required this.nama,
      required this.email,
      required this.password,
      required this.alamat,
      required this.telepon,
      required this.role,
      required this.photo});

  toJson() {
    return {
      "Nama": nama,
      "Email": email,
      "Password": password,
      "Alamat": alamat,
      "Telepon": telepon,
      "Role": role,
      "Photo": photo,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      documentID: document.id,
      nama: data["Nama"],
      email: data["Email"],
      password: data["Password"],
      alamat: data["Alamat"],
      telepon: data["Telepon"],
      role: data["Role"],
      photo: data["Photo"],
    );
  }
}
