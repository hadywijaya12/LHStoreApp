import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lhstore/app/modules/product/views/detail_product.dart';
import 'package:lhstore/app/widget/loading_indicator.dart';
import 'package:lhstore/models/product_model.dart';
import 'package:lhstore/service/product_service.dart';

import '../controllers/product_controller.dart';
import '../../home/views/homepage.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var currentIndex = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(22, 45, 20, 0),
            child: Row(
              children: [
                Text(
                  "Semua Produk",
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color(0xff858585),
                isDense: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "Search Anythings",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff858585)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 229, 212),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: StreamBuilder(
                stream: ProductService.getProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => detailProduct(
                                      title: data[index].reference.id,
                                      data: data[index],
                                      currentIndex: currentIndex)));
                            },
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Image.network(
                                    data[index]["Photo"],
                                    width: 100,
                                    height: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        data[index]["Nama"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Rp. ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffF58244)),
                                        ),
                                        Text(
                                          data[index]["Harga"],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffF58244)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  // } else {
                  //   return Container(
                  //     child: Column(
                  //       children: [
                  //         SizedBox(
                  //           height: 60,
                  //         ),
                  //         Center(
                  //           child: CircularProgressIndicator(),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
                },
              ))
        ],
      ),
    );
  }
}

// GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               detailProduct(currentIndex: currentIndex)));
//                     },
//                     child: Container(
//                       height: 250,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             products[index].image,
//                             width: 100,
//                             height: 100,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 products[index].title,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 13),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   products[index].price,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xffF58244)),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
                // }),