import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? productId;
  final String? nama;
  final String? harga;
  final String? deskripsi;
  final String? photo;
  final String? stok;

  const Product({
    this.productId,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.photo,
    required this.stok,
  });

  toJson() {
    return {
      "productId": productId,
      "Nama": nama,
      "Harga": harga,
      "Deskripsi": deskripsi,
      "Photo": photo,
      "Stok": stok,
    };
  }

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Product(
      productId: document.id,
      nama: data["Nama"],
      harga: data["Harga"],
      deskripsi: data["Deskripsi"],
      photo: data["Photo"],
      stok: data["Stok"],
    );
  }
}
