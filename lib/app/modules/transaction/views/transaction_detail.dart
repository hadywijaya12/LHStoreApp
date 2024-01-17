import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lhstore/app/modules/home/views/home.dart';

class transactionDetail extends StatefulWidget {
  final dynamic data;
  const transactionDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<transactionDetail> createState() => _transactionDetailState(data);
}

class _transactionDetailState extends State<transactionDetail> {
  @override
  final dynamic data;
  var dataTanggal = new DateFormat('dd-MMM-yyyy hh:mm a');
  _transactionDetailState(this.data);
  Widget build(BuildContext context) {
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
              Get.offAll(home(currentIndex: 2));
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          title: Text(
            "Transaction Detail",
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
                    "ID Order: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    data["Order_id"],
                    style: TextStyle(
                        fontSize: 18,
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
                  Text(
                    "Status Pesanan: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    data["Status"],
                    style: TextStyle(
                        fontSize: 18,
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
                  Text(
                    "Status Pembayaran: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    data["Payment"],
                    style: TextStyle(
                        fontSize: 18,
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
                  Text(
                    "Alamat Pengantaran: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Text(
                data["Alamat"],
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                children: [
                  Text(
                    "Tanggal Order: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Row(
                children: [
                  Text(
                    dataTanggal.format(data["Order_date"].toDate()),
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                children: [
                  Text(
                    "Bukti Bayar: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SizedBox(
                height: 400,
                width: 400,
                child: Image(
                  image: NetworkImage("${data["Bukti_bayar"]}"),
                  height: 400,
                  width: 400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Produk",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['Orders'].length, (index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
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
                                color: Color(0xffF58244).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.network(
                                "${data['Orders'][index]["Photo"]}.to"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['Orders'][index]["Nama"] +
                                " x" +
                                data['Orders'][index]["Quantity"].toString(),
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
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: data['Orders'][index]["Tprice"]
                                        .toString(),
                                    style: TextStyle(color: Color(0xffF58244)))
                              ]))
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                children: [
                  Text(
                    "Total Harga Barang: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Rp. ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF58244)),
                  ),
                  Text(
                    data["Total_harga_barang"],
                    style: TextStyle(
                        fontSize: 18,
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
                  Text(
                    "Total Ongkos Kirim: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Rp. ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF58244)),
                  ),
                  Text(
                    data["Total_ongkir"],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF58244)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 30),
              child: Row(
                children: [
                  Text(
                    "Total Harga: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Rp. ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF58244)),
                  ),
                  Text(
                    data["Total_amount"],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF58244)),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
