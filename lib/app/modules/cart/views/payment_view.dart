// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:lhstore/app/modules/home/views/home.dart';

// class paymentView extends StatefulWidget {
//   const paymentView({super.key});

//   @override
//   State<paymentView> createState() => _paymentViewState();
// }

// class _paymentViewState extends State<paymentView> {
//   @override
//   var currentIndex = 0;
//   Widget build(BuildContext context) {
//     return Scaffold(body: CircularProgressIndicator()
//         //     InAppWebView(
//         //   initialOptions: InAppWebViewGroupOptions(
//         //       crossPlatform: InAppWebViewOptions(
//         //     useShouldOverrideUrlLoading: true,
//         //   )),
//         //   initialUrlRequest: URLRequest(url: Uri.parse("")),
//         //   shouldOverrideUrlLoading: ((controller, navigationAction) async {
//         //     final url = navigationAction.request.url.toString();
//         //     if (url.contains("example.com")) {
//         //       Get.offAll(home(currentIndex: currentIndex));
//         //       const snackbar = SnackBar(content: Text("Transaksi Berhasil!"));
//         //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//         //       return NavigationActionPolicy.CANCEL;
//         //     }
//         //     return NavigationActionPolicy.ALLOW;
//         //   }),
//         // )
//         );
//   }
// }
