import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lhstore/models/product_model.dart';

class ProductService {
  static getProducts() {
    return FirebaseFirestore.instance.collection("Products").snapshots();
  }
  // Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots() {
  //   return FirebaseFirestore.instance.collection("Products").snapshots();
  // }

  // Future<List<Map<String, dynamic>>> get() async {
  //   try {
  //     var snapshot =
  //         await FirebaseFirestore.instance.collection("Products").get();
  //     final allData = snapshot.docs.map((doc) => doc.data()).toList();
  //     print(allData);
  //     return allData;
  //   } on Exception catch (err) {
  //     return [];
  //   }
  // }
}
