import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lhstore/models/order_model.dart';
import 'package:lhstore/models/product_model.dart';
import 'package:lhstore/service/payment_service.dart';
import 'package:lhstore/service/user_service.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final count = 0.obs;
  var totalP = 0.obs;
  var ongkir = 0.obs;
  var hargaAkhir = 0.obs;

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

  static getCart(uid) {
    return FirebaseFirestore.instance
        .collection("Cart")
        .where("added_by", isEqualTo: uid.toString())
        .snapshots();
  }

  static deleteCart(docId) {
    return FirebaseFirestore.instance.collection("Cart").doc(docId).delete();
  }

  calculate(data) {
    totalP.value = 0;
    ongkir.value = 0;
    hargaAkhir.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]["Tprice"].toString());
    }
    if (totalP.value != 0) {
      ongkir.value = 7000;
    }
    hargaAkhir.value = totalP.value + ongkir.value;
  }

  late dynamic productSnapshot;
  late dynamic productSnapshots;
  var products = [];
  // var productss = [];
  placeMyOrder(dataAlamat, dataNama, dataTelp, totalAmount, id,
      totalHargaBarang, totalOngkir) async {
    await getProductDetails();

    await FirebaseFirestore.instance.collection("Orders").doc().set({
      'Order_by': currentUser().toString(),
      'Order_id': id.toString(),
      'Order_date': FieldValue.serverTimestamp(),
      'Order_by_name': dataNama.toString(),
      'Order_by_email': currentEmail().toString(),
      'Order_by_telp': dataTelp.toString(),
      'Total_amount': totalAmount,
      'Total_harga_barang': totalHargaBarang,
      'Total_ongkir': totalOngkir,
      'Alamat': dataAlamat.toString(),
      'Bukti_bayar': "",
      'Payment': "Pending",
      'Status': "Pending",
      'Orders': FieldValue.arrayUnion(products)
    });
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'Nama': productSnapshot[i]["Nama"],
        'Photo': productSnapshot[i]["Photo"],
        'Quantity': productSnapshot[i]["Quantity"],
        'Tprice': productSnapshot[i]["Tprice"],
      });
    }
  }

  // getProductDetailss() {
  //   productss.clear();
  //   for (var i = 0; i < productSnapshots.length; i++) {
  //     productss.add({
  //       'id': productSnapshots[i].id,
  //       'name': productSnapshots[i]["Nama"],
  //       'price': productSnapshots[i]["Quantity"],
  //       'quantity': productSnapshots[i]["Tprice"],
  //     });
  //   }
  // }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      FirebaseFirestore.instance
          .collection("Cart")
          .doc(productSnapshot[i].id)
          .delete();
    }
  }

  getData(id) async {
    var data = await FirebaseFirestore.instance
        .collection("Products")
        .doc(id)
        .get()
        .then((value) => value.data()!["Stok"].toString());
    return data;
  }

  getIdOrder(id) {
    print("id" + id.toString());

    return FirebaseFirestore.instance
        .collection("Orders")
        .where("Order_id", isEqualTo: id.toString())
        .snapshots();
    // final dataA = data.docs.map((e) => OrderModel.fromSnapshot(e)).single;

    // return dataA;
  }

  updateStok(quantity, stok, title) {
    var quantityBaru =
        int.parse(stok.toString()) + int.parse(quantity.toString());
    print(int.parse(quantityBaru.toString()));
    try {
      FirebaseFirestore.instance
          .collection("Products")
          .doc(title)
          .update({"Stok": quantityBaru});
    } on Exception catch (err) {
      print(err);
    }
  }

  updateOrder(imageUrl, idOrder) {
    print(imageUrl);
    print("idOrder" + idOrder);
    FirebaseFirestore.instance.collection("Orders").doc(idOrder).update({
      "Bukti_bayar": imageUrl,
      "Payment": "Checking",
      "Status": "Confirmed",
    });
    // try {
    //   var data = FirebaseFirestore.instance
    //       .collection("Orders")
    //       .where("Order_id", isEqualTo: idOrder)
    //       .get()
    //       .then((val) => {
    //             val.docs.forEach((element) {
    //               element.reference
    //                   .update({"Bukti_bayar": imageUrl.toString()});
    //             })
    //           });
    //   print(data);
    // } catch (err) {
    //   print(err);
    // }
  }

  // getPaymentLink(total, id) async {
  //   var paymentUrl =
  //       await PaymentService().createPaymentLink(productss, total, id);
  //   print(paymentUrl);
  // }
}
