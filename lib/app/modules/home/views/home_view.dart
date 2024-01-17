import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
// import './home.dart';
// import './homepage.dart';
// import '../../cart/views/cart_view.dart';
// import '../../transaction/views/transaction_view.dart';
// import '../../setting/views/setting_view.dart';
// import '../../product/views/product_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class home extends StatefulWidget {
//   const home({super.key});

//   @override
//   State<home> createState() => _homeState();
// }

// class _homeState extends State<home> {
  // var currentIndex = 0;
  // final pages = [
  //   homePage(),
  //   ProductView(),
  //   TransactionView(),
  //   CartView(),
  //   SettingView(),
  // ];
  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           Color.fromARGB(255, 255, 241, 233),
  //           Color.fromARGB(255, 245, 245, 245)
  //         ],
  //       ),
  //     ),
  //     child: Scaffold(
  //       backgroundColor: Colors.transparent,
  //       bottomNavigationBar: Container(
  //         margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
  //         height: size.width * .165,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(25)),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Color(0xffBDBDBD).withOpacity(0.15),
  //                 blurRadius: 15,
  //               )
  //             ]),
  //         child: ListView.builder(
  //           itemCount: 5,
  //           scrollDirection: Axis.horizontal,
  //           padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
  //           itemBuilder: (context, index) => InkWell(
  //             onTap: () {
  //               setState(() {
  //                 currentIndex = index;
  //               });
  //             },
  //             splashColor: Colors.transparent,
  //             highlightColor: Colors.transparent,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 AnimatedContainer(
  //                   duration: Duration(milliseconds: 1500),
  //                   curve: Curves.fastLinearToSlowEaseIn,
  //                   margin: EdgeInsets.only(
  //                     bottom: index == currentIndex ? 0 : size.width * .029,
  //                     right: size.width * .0210,
  //                     left: size.width * .0210,
  //                   ),
  //                   width: size.width * .128,
  //                   height: index == currentIndex ? size.width * .01 : 0,
  //                   decoration: BoxDecoration(
  //                       color: Color(0xffF58244),
  //                       borderRadius: BorderRadius.all(Radius.circular(20))),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       currentIndex = index;
  //                     });
  //                   },
  //                   icon: index == currentIndex
  //                       ? imgList[index]
  //                       : imgListNotActive[index],
  //                   iconSize: 20,
  //                 ),
  //                 SizedBox(
  //                   height: size.width * .01,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       body: pages[currentIndex],
  //     ),
  //   );
  // }

  // List imgList = [
  //   Image.asset("assets/logo/home-active.png"),
  //   Image.asset("assets/logo/product-active.png"),
  //   Image.asset("assets/logo/transaction-active.png"),
  //   Image.asset("assets/logo/cart-active.png"),
  //   Image.asset("assets/logo/setting-active.png")
  // ];
  // List imgListNotActive = [
  //   Image.asset("assets/logo/home.png"),
  //   Image.asset("assets/logo/product.png"),
  //   Image.asset("assets/logo/transaction.png"),
  //   Image.asset("assets/logo/cart.png"),
  //   Image.asset("assets/logo/setting.png")
  // ];
// }
