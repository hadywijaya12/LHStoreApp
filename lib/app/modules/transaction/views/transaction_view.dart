import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lhstore/app/modules/transaction/views/transaction_detail.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22, 45, 20, 0),
            child: Row(
              children: [
                Text(
                  "Transaksi",
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
            stream: TransactionController().getAllOrders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Container(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.offAll(
                                    transactionDetail(data: data[index]));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 5),
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
                                                  BorderRadius.circular(15)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${index + 1}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 106, 106, 106),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
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
                                          data[index]["Order_id"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                  255, 56, 56, 56),
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
                                                  text: data[index]
                                                          ["Total_amount"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xffF58244)))
                                            ])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: "Order status: ",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 56, 56, 56),
                                                fontWeight: FontWeight.w500),
                                            children: [
                                              TextSpan(
                                                text: data[index]["Status"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 56, 56, 56),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: Text("Belum ada transaksi"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
