import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/modules/product/controllers/product_controller.dart';
import 'package:lhstore/service/product_service.dart';
import '../../home/views/home.dart';

class detailProduct extends StatefulWidget {
  final title;
  final currentIndex;
  final dynamic data;
  detailProduct(
      {Key? key, required this.title, required this.currentIndex, this.data})
      : super(key: key);

  @override
  State<detailProduct> createState() =>
      _detailProductState(title, currentIndex, data);
}

class _detailProductState extends State<detailProduct> {
  final title;
  var currentIndex;
  final dynamic data;
  var controller = ProductController();
  _detailProductState(this.title, this.currentIndex, this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 223, 205),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              controller.resetValue();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => home(currentIndex: currentIndex)));
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          title: Text(
            "Detail Product",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Image.network(data["Photo"]),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 241, 233),
                    Color.fromARGB(255, 245, 245, 245)
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data["Nama"],
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffF58244)),
                          ),
                          Text(
                            data["Harga"],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffF58244)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Text(
                        data["Deskripsi"],
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff616161)),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Stok tersedia: ",
                            style: TextStyle(
                                fontSize: 17, color: Color(0xff616161)),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            data["Stok"].toString(),
                            style: TextStyle(
                                fontSize: 17, color: Color(0xff616161)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price: ",
                            style: TextStyle(
                                fontSize: 17, color: Color(0xff616161)),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "Rp. ",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffF58244)),
                          ),
                          Text(
                            controller.totalPrice.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffF58244)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            width: 130,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFFF58244).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(data["Harga"]));
                                  }),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xFFF58244),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.quantity.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    controller.increaseQuantity(
                                        int.parse(data["Stok"].toString()));
                                    controller.calculateTotalPrice(
                                        int.parse(data["Harga"]));
                                  }),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xFFF58244),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (controller.quantity.value == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Quantity tidak bisa 0!")));
                                    return;
                                  } else {
                                    var nama = data["Nama"];
                                    var stok = data["Stok"];

                                    controller.addToCart(
                                      idProduct: title,
                                      photo: data["Photo"],
                                      nama: data["Nama"],
                                      quantity: controller.quantity.value,
                                      harga: data["Harga"],
                                      tprice: controller.totalPrice.value,
                                    );
                                    controller.updateStok(
                                      controller.quantity.value,
                                      nama,
                                      stok,
                                      title,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Ditambah ke keranjang!")));
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          home(currentIndex: 3)));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFF58244),
                                    side: BorderSide.none,
                                    shape: StadiumBorder()),
                                child: Text(
                                  "Add to Cart",
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
