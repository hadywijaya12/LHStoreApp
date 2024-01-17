import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/app/modules/login/views/login_view.dart';
import 'package:lhstore/app/modules/register/views/register_view.dart';
import 'package:lhstore/firebase_options.dart';
import 'package:lhstore/service/auth_service.dart';

import 'app/routes/app_pages.dart';

import 'app/widget/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthService()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: CircularProgressIndicator(),
      getPages: AppPages.routes,
    );
    // return FutureBuilder(
    //     future: Future.delayed(const Duration(seconds: 3)),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const SplashScreen();
    //       } else {
    //         return GetMaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           title: "Application",
    //           home: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }
}

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   var currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.all(20),
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
//           itemCount: 4,
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
//                     right: size.width * .422,
//                     left: size.width * .422,
//                   ),
//                   width: size.width * .128,
//                   height: index == currentIndex ? size.width * .014 : 0,
//                   decoration: BoxDecoration(
//                       color: Color(0xffF58244),
//                       borderRadius: BorderRadius.all(Radius.circular(20))),
//                 ),
//                 Icon(
//                   listOfIcons[index],
//                   size: size.width * .076,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.favorite_rounded,
//     Icons.settings_rounded,
//     Icons.person_rounded
//   ];
// }
