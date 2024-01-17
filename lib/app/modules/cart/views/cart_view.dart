import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lhstore/app/modules/cart/views/order_detail.dart';
import 'package:lhstore/app/modules/product/controllers/product_controller.dart';
import 'package:lhstore/app/widget/loading_indicator.dart';
import 'package:lhstore/service/user_service.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  var stok;
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22, 45, 20, 0),
            child: Row(
              children: [
                Text(
                  "Keranjang",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(22, 10, 20, 0),
            child: Row(
              children: [
                Container(
                  height: 4,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffF58244),
                      borderRadius: BorderRadius.circular(50)),
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: CartController.getCart(currentUser()),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  controller.calculate(data);
                  return Column(
                    children: [
                      Container(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  FutureBuilder(
                                      future: controller
                                          .getData(data[index]["idProduct"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          stok = snapshot.data;
                                          return Container();
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 5),
                                    child: Dismissible(
                                      direction: DismissDirection.horizontal,
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        var title = data[index]["idProduct"];
                                        var quantity = data[index]["Quantity"];
                                        // var datas = controller.getData(title);
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          CartController.deleteCart(
                                              data[index].id);
                                          controller.updateStok(
                                              quantity, stok, title);
                                        }
                                      },
                                      background: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: Color(0xffffe6e6),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            SvgPicture.asset(
                                                "assets/logo/trash.svg"),
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: AspectRatio(
                                              aspectRatio: 0.88,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF58244)
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Image.network(
                                                    "${data[index]["Photo"]}"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index]["Nama"] +
                                                    " x" +
                                                    data[index]["Quantity"]
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text.rich(TextSpan(
                                                  text: "Rp. ",
                                                  style: TextStyle(
                                                      color: Color(0xffF58244),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  children: [
                                                    TextSpan(
                                                        text: data[index]
                                                                ["Tprice"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF58244)))
                                                  ]))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                              // return ListTile(
                              //   leading: SizedBox(
                              //     width: 80,
                              //     height: 200,
                              //     child: Container(
                              //       padding: EdgeInsets.all(10),
                              //       decoration: BoxDecoration(
                              //           color: Color(0xffF58244).withOpacity(0.2),
                              //           borderRadius: BorderRadius.circular(15)),
                              //       child:
                              //           Image.network("${data[index]["Photo"]}"),
                              //     ),
                              //   ),
                              // );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Row(
                          children: [
                            const Text(
                              "Subtotal: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "Rp. ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF58244)),
                            ),
                            Obx(
                              () => Text(
                                "${controller.totalP.value}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF58244)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            const Text(
                              "Ongkos Kirim: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "Rp. ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF58244)),
                            ),
                            Obx(
                              () => Text(
                                "${controller.ongkir.value}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF58244)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "Rp. ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF58244)),
                            ),
                            Obx(
                              () => Text(
                                "${controller.hargaAkhir.value}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF58244)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if ("${controller.hargaAkhir.value}" != "0") {
                                var test = "aa";
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => orderDetail(
                                          tests: test,
                                        )));
                              } else if ("${controller.hargaAkhir.value}" ==
                                  "0") {
                                const snackbar = SnackBar(
                                    content:
                                        Text("Tidak ada produk di keranjang!"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                              // CartController.getCart(currentUser());
                            },
                            child: Text(
                              "Proses",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 245, 130, 68),
                                minimumSize: Size(50, 42)),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text("Keranjang Anda Kosong"),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              }),
        ],
      ),
    );
  }
}

// class CartView extends GetView<CartController> {
//   const CartView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
