import 'package:flutter/material.dart';
// import './home_view.dart';

class wow extends StatefulWidget {
  const wow({super.key});

  @override
  State<wow> createState() => _wowState();
}

class _wowState extends State<wow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Welcome, Wow!\n",
                            style: TextStyle(
                              fontSize: 24,
                              height: 2,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                        TextSpan(
                          text: "Select the service according to\nyour wishes",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff616161),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => home()),
                // );
              },
              icon: Image.asset("assets/logo/gg.png"))
        ],
      ),
    );
  }
}
