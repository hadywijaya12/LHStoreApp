import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:lhstore/app/routes/app_pages.dart';
import 'package:lhstore/models/user_model.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return register();
  }
}

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final controller = Get.put(RegisterController());

  final _formKey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Mohon masukkan email yang valid';
    }
    return null;
  }

  bool _isObsecure = true;
  bool _isObsecurea = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
              child: Text(
                "Enter your username, email address, password, and confirm the password for register. ",
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
                      Icons.people,
                      size: 28,
                    ),
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 232, 232, 232)),
                validator: (nama) =>
                    nama!.length < 1 ? "Nama tidak boleh kosong" : null,
                onChanged: (value) {
                  controller.nama = value;
                },
              ),
            ),
            SizedBox(height: 20),
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
                onChanged: (value) {
                  controller.email = value;
                },
                validator: validateEmail,
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
                onChanged: (value) {
                  controller.password = value;
                },
                validator: (password) =>
                    password!.length < 6 ? "Password minimal 6 karakter" : null,
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: ElevatedButton(
                onPressed: () {
                  final user = UserModel(
                      nama: controller.nama,
                      email: controller.email,
                      password: controller.password,
                      alamat: "",
                      telepon: "",
                      role: "user",
                      photo: "");
                  if (_formKey.currentState!.validate()) {
                    controller.register(context, user);
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 245, 130, 68),
                    minimumSize: Size(50, 42)),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offAllNamed(Routes.LOGIN),
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

  Widget retooglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isObsecurea = !_isObsecurea;
        });
      },
      icon: _isObsecurea ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
