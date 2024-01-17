import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? productId;
  final String? Bukti_bayar;
  final String? Order_by;
  final String? Order_by_email;
  final String? Order_by_nama;
  final String? Order_by_telp;
  final String? Order_date;
  final String? Order_id;
  final Map? Orders;
  final String? Payment;
  final String? Status;
  final String? Total_amount;
  final String? Total_harga_barang;
  final String? Total_ongkir;

  const OrderModel({
    this.productId,
    this.Bukti_bayar,
    this.Order_by,
    this.Order_by_email,
    this.Order_by_nama,
    this.Order_by_telp,
    this.Order_date,
    this.Order_id,
    this.Orders,
    this.Payment,
    this.Status,
    this.Total_amount,
    this.Total_harga_barang,
    this.Total_ongkir,
  });

  toJson() {
    return {
      "Id": productId,
      "Bukti_bayar": Bukti_bayar,
      "Order_by": Order_by,
      "Order_by_email": Order_by_email,
      "Order_by_nama": Order_by_nama,
      "Order_by_telp": Order_by_telp,
      "Order_date": Order_date,
      "Order_id": Order_id,
      "Orders": Orders,
      "Payment": Payment,
      "Status": Status,
      "Total_amount": Total_amount,
      "Total_harga_barang": Total_harga_barang,
      "Total_ongkir": Total_ongkir,
    };
  }

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OrderModel(
      productId: document.id,
      Bukti_bayar: data["Bukti_bayar"],
      Order_by: data["Order_by"],
      Order_by_email: data["Order_by_email"],
      Order_by_nama: data["Order_by_nama"],
      Order_by_telp: data["Order_by_telp"],
      Order_date: data["Order_date"],
      Order_id: data["Order_id"],
      Orders: data["Orders"],
      Payment: data["Payment"],
      Status: data["Status"],
      Total_amount: data["Total_amount"],
      Total_harga_barang: data["Total_harga_barang"],
      Total_ongkir: data["Total_ongkir"],
    );
  }
}
