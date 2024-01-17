import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/cart/controllers/cart_controller.dart';
import 'package:lhstore/app/modules/cart/controllers/payment_controller.dart';
import 'package:lhstore/app/modules/cart/views/cart_view.dart';
import 'package:lhstore/app/modules/cart/views/pembayaran_view.dart';
import 'package:lhstore/app/modules/setting/controllers/setting_controller.dart';
import 'package:lhstore/app/modules/setting/views/edit_profile.dart';
import 'package:lhstore/models/user_model.dart';
import 'package:lhstore/service/payment_service.dart';
import 'package:lhstore/service/user_service.dart';
import '../../home/views/home.dart';

class orderDetail extends StatefulWidget {
  final tests;
  const orderDetail({Key? key, required this.tests}) : super(key: key);

  @override
  State<orderDetail> createState() => _orderDetailState(tests);
}

class _orderDetailState extends State<orderDetail> {
  final tests;
  _orderDetailState(this.tests);
  var dataAlamat;
  var dataNama;
  var dataTelp;
  var id = DateTime.now().microsecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    final controllers = Get.put(SettingController());
    // final controllerss = Get.put(PaymentService());
    // final controllersss = Get.put(PaymentController());
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 241, 233),
            Color.fromARGB(255, 245, 245, 245)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (tests == "test") {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => home(currentIndex: 3)));
              } else {
                Get.back();
              }
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          title: Text(
            "Order Detail",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "ID Pesanan",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Row(
                  children: [
                    Text(
                      id.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF58244)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "Alamat Pengataran",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "(Mohon sertakan alamat dengan jelas)",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: controllers.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      dataAlamat = userData.alamat.toString();
                      dataNama = userData.nama.toString();
                      dataTelp = userData.telepon.toString();
                      return Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  userData.alamat.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: InkWell(
                                      onTap: () {
                                        var nama = "detail";
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    editProfile(namas: nama)));
                                      },
                                      child: Text(
                                        "Ubah Alamat",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffF58244),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  } else {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "Nomor Telepon",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "(Pastikan nomor telepon dapat dihubungi)",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: controllers.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      dataAlamat = userData.alamat.toString();
                      dataNama = userData.nama.toString();
                      dataTelp = userData.telepon.toString();
                      return Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      userData.telepon.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: InkWell(
                                      onTap: () {
                                        var nama = "detail";
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    editProfile(namas: nama)));
                                      },
                                      child: Text(
                                        "Ubah Telepon",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffF58244),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  } else {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      "Item",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: CartController.getCart(currentUser()),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      if (tests == "test") {
                        controller.calculate(data);
                      }
                      controller.productSnapshot = data;
                      controller.productSnapshots = data;
                      return Column(
                        children: [
                          Container(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 5),
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
                                                  fontWeight: FontWeight.w500),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Rp. ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
                                ),
                                Text(
                                  "${controller.totalP.value}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Rp. ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
                                ),
                                Text(
                                  "${controller.ongkir.value}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Rp. ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
                                ),
                                Text(
                                  "${controller.hargaAkhir.value}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF58244)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 30),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  var totalAmount =
                                      "${controller.hargaAkhir.value}";
                                  var totalHargaBarang =
                                      "${controller.totalP.value}";
                                  var totalOngkir =
                                      "${controller.ongkir.value}";
                                  if (dataAlamat == "" || dataTelp == "") {
                                    const snackbar = SnackBar(
                                        content: Text(
                                            "Alamat dan nomor telepon tidak boleh kosong!"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    await controller.placeMyOrder(
                                      dataAlamat,
                                      dataNama,
                                      dataTelp,
                                      totalAmount,
                                      id,
                                      totalHargaBarang,
                                      totalOngkir,
                                    );
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => pembayaran(
                                                  id: id,
                                                  totalAmount: totalAmount,
                                                  dataNama: dataNama,
                                                )));
                                  }

                                  // await controller.getProductDetailss();
                                  // await controller.getPaymentLink(
                                  //     totalAmount, id);
                                },
                                child: Text(
                                  "Pembayaran",
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
        ),
      ),
    );
  }
}
