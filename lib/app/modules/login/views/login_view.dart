import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lhstore/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final controller = LoginController();
  bool _isObsecure = true;
  var currentIndex = 0;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Mohon masukkan email yang valid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
              child: Text(
                "Enter your email address and password You are to log in.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIconColor: Color(0xff858585),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 28,
                    ),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 232, 232, 232)),
                validator: validateEmail,
                onChanged: (value) {
                  controller.email = value;
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: TextFormField(
                obscureText: _isObsecure,
                decoration: InputDecoration(
                    prefixIconColor: Color(0xff858585),
                    prefixIcon: Icon(
                      Icons.key,
                      size: 28,
                    ),
                    suffixIcon: tooglePassword(),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 232, 232, 232)),
                validator: (password) =>
                    password!.length < 1 ? "password tidak boleh kosong" : null,
                onChanged: (value) {
                  controller.password = value;
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text(
                "Forgot Password?",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: ElevatedButton(
                onPressed: () => {
                  _formKey.currentState!.validate(),
                  controller.login(context)
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 245, 130, 68),
                    minimumSize: Size(50, 42)),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Text(
                "Or sign in with one click",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset("assets/logo/fb.png"),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset("assets/logo/gg.png"),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offAllNamed(Routes.REGISTER),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tooglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isObsecure = !_isObsecure;
        });
      },
      icon: _isObsecure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
