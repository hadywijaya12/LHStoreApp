// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:lhstore/app/modules/home/views/homepage.dart';
// import 'package:lhstore/service/user_service.dart';

// class PaymentService {
//   Dio dio = Dio();

//   dynamic productSnapshots;
//   Future<String?> createPaymentLink(productss, total, id) async {
//     var uuid = currentUser();

//     // var products = [];
//     // for (var i = 0; i < productSnapshots.length; i++) {
//     //   products.add({
//     //     'Nama': productSnapshots[i]["Nama"],
//     //     'Photo': productSnapshots[i]["Photo"],
//     //     'Quantity': productSnapshots[i]["Quantity"],
//     //     'Tprice': productSnapshots[i]["Tprice"],
//     //   });
//     // }

//     var data = jsonEncode({
//       'transaction_details': {
//         'order_id': id,
//         'gross_amount': int.parse(total),
//         'payment_link_id': uuid,
//       },
//       'credit_card': {
//         'secure': true,
//       },
//       'usage_limit': 1,
//       'expiry': {
//         'duration': 1,
//         'unit': 'days',
//       },
//       'item_details': productss,
//       'customer_details': {
//         "first_name": "John",
//         "last_name": "Doe",
//         "email": "john.doe@midtrans.com",
//         "phone": "+62181000000000",
//         "notes":
//             "Thank you for your purchase. Please follow the instructions to pay."
//       },
//     });
//     print(data);
//     try {
//       var response = await dio.post(
//         "https://api.sandbox.midtrans.com/v1/payment-links",
//         options: Options(
//           headers: {
//             "Accept": "application/json",
//             "Content-Type": "application/json",
//             "Authorization":
//                 "Basic TWlkLXNlcnZlci1IaE1GTEFlSXNPeEZqZTM4emxmQkU3YUo6",
//           },
//         ),
//         data: data,
//       );
//       print(response.data);
//       return response.data;
//     } on Exception catch (err) {
//       print(err);
//     }
//   }
// }
