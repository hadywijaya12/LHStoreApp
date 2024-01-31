import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhstore/app/modules/product/views/detail_product.dart';
import 'package:lhstore/app/modules/setting/controllers/setting_controller.dart';
import 'package:lhstore/models/user_model.dart';
import 'package:lhstore/service/product_service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List _allResults = [];
  List _resultlist = [];
  final TextEditingController _searchController = TextEditingController();

  void initState() {
    getClientStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResults) {
        var name = clientSnapShot['Nama'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultlist = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection("Products")
        .orderBy("Nama")
        .get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  void didChangeDependecies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Welcome " +
                                        userData.nama.toString() +
                                        "! \n",
                                    style: TextStyle(
                                      fontSize: 22,
                                      height: 3,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text:
                                      "Select the product according to\nyour wishes",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff616161),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
                            child: SizedBox(
                              width: 62,
                              height: 62,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(userData.photo ??
                                    "https://img.freepik.com/free-vector/illustration-camera-icon_53876-5563.jpg?w=740&t=st=1701882732~exp=1701883332~hmac=9f8d2dbf40cf010cad3a7a4bba6ed5e3dd6b35b40d039e9ded35c2c7bdc3263a"),
                                radius: 100,
                              ),
                            ),
                          )
                        ],
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
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CupertinoSearchTextField(
              controller: _searchController,
              padding: EdgeInsets.all(15),
              placeholder: "Search Anythings",
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 229, 212),
                  borderRadius: BorderRadius.circular(8)),
              // decoration: InputDecoration(
              //   prefixIcon: Icon(Icons.search),
              //   prefixIconColor: Color(0xff858585),
              //   isDense: true,
              //   isCollapsed: true,
              //   contentPadding: EdgeInsets.all(15),
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10.0),
              //     borderSide: BorderSide(
              //       width: 0,
              //       style: BorderStyle.none,
              //     ),
              //   ),
              //   hintText: "Search Anythings",
              //   hintStyle: TextStyle(fontSize: 14, color: Color(0xff858585)),
              //   filled: true,
              //   fillColor: Color.fromARGB(255, 255, 229, 212),
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage("assets/logo/banner.png"),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Jenis Produk",
          //         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(22, 10, 20, 0),
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 4,
          //         width: 70,
          //         decoration: BoxDecoration(
          //             color: Color(0xffF58244),
          //             borderRadius: BorderRadius.circular(50)),
          //       )
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18, 13, 20, 0),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: [
          //         jenis(
          //           image: "assets/logo/oil.png",
          //           title: "Minyak",
          //         ),
          //         jenis(
          //           image: "assets/logo/spices.png",
          //           title: "Bumbu",
          //         ),
          //         jenis(
          //           image: "assets/logo/mushroom.png",
          //           title: "Jamur",
          //         ),
          //         jenis(
          //           image: "assets/logo/rice.png",
          //           title: "Beras",
          //         ),
          //         jenis(
          //           image: "assets/logo/cracker.png",
          //           title: "Kerupuk",
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 20, 20, 0),
            child: Row(
              children: [
                Text(
                  "Produk",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
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
                        itemCount: _resultlist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => detailProduct(
                                        title: _resultlist[index].reference.id,
                                        currentIndex: currentIndex,
                                        data: _resultlist[index],
                                      )));
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
                                    _resultlist[index]["Photo"],
                                    width: 100,
                                    height: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        _resultlist[index]["Nama"],
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
                                          _resultlist[index]["Harga"],
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

class jenis extends StatelessWidget {
  final String image;
  final String title;
  const jenis({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 60,
            height: 70,
            child: Column(
              children: [
                Image.asset(
                  image,
                  width: 40,
                ),
                SizedBox(
                  height: 13,
                ),
                Text(title)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class product {
//   final String title;
//   final String image;
//   final String price;

//   product({
//     required this.title,
//     required this.image,
//     required this.price,
//   });
// }

// final List<product> productss = [
//   product(
//       title: "Minyak Goreng Bimoli 1 Liter",
//       image: "assets/image/bimoli.png",
//       price: "Rp. 17000"),
//   product(
//       title: "Masako Ayam 250 Gram",
//       image: "assets/image/masako250g.png",
//       price: "Rp. 10000"),
//   product(
//       title: "Beras Anak Raja 5 Kg",
//       image: "assets/image/berasanakraja.png",
//       price: "Rp. 65000"),
//   product(
//       title: "Garam Cap Bentul",
//       image: "assets/image/garambentul.png",
//       price: "Rp. 2000"),
// ];
