import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhstore/app/modules/setting/controllers/setting_controller.dart';
import 'package:lhstore/app/modules/setting/views/utils.dart';
import 'package:lhstore/models/user_model.dart';
import '../../home/views/home.dart';

class editProfile extends StatefulWidget {
  final namas;
  editProfile({Key? key, required this.namas}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState(namas);
}

class _editProfileState extends State<editProfile> {
  var currentIndex = 4;
  final namas;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _editProfileState(this.namas);
  String? _image;
  void selectImage() async {
    String img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // Future<String> uploadImageToStorage(String childName, Uint8List file) async {
  //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference ref = _storage.ref().child(childName).child(uniqueFileName);
  //   UploadTask uploadTask = ref.putData(file);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // String? imageUrl;
  // Future<String> untukGambar(Uint8List file) async {
  //   imageUrl = await uploadImageToStorage("profileImage", file);
  //   return imageUrl.toString();
  // }

  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    String url =
        "https://img.freepik.com/free-vector/illustration-camera-icon_53876-5563.jpg?w=740&t=st=1701882732~exp=1701883332~hmac=9f8d2dbf40cf010cad3a7a4bba6ed5e3dd6b35b40d039e9ded35c2c7bdc3263a";
    final controller = Get.put(SettingController());
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
            ),
            title: Text(
              "Edit Profil",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    final nama = TextEditingController(text: userData.nama);
                    String? idd = userData.documentID;
                    final telepon =
                        TextEditingController(text: userData.telepon);
                    final alamat = TextEditingController(text: userData.alamat);
                    String? email = userData.email;
                    var passwordd = userData.password;
                    String? imageUrl = userData.photo;
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    // imageUrl != null
                                    //     ? SizedBox(
                                    //         height: 130,
                                    //         width: 130,
                                    //         child: CircleAvatar(
                                    //           radius: 100,
                                    //           backgroundImage:
                                    //               NetworkImage(imageUrl),
                                    //         ),
                                    //       )
                                    //     :
                                    SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: CircleAvatar(
                                        radius: 100,
                                        backgroundImage: NetworkImage(userData
                                                .photo ??
                                            "https://img.freepik.com/free-vector/illustration-camera-icon_53876-5563.jpg?w=740&t=st=1701882732~exp=1701883332~hmac=9f8d2dbf40cf010cad3a7a4bba6ed5e3dd6b35b40d039e9ded35c2c7bdc3263a"),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Color(0xffF58244)),
                                          child: IconButton(
                                            onPressed: () async {
                                              ImagePicker imagePicker =
                                                  ImagePicker();
                                              XFile? file =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              print('${file?.path}');

                                              if (file == null) return;
                                              String uniqueFileName =
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDirImages =
                                                  referenceRoot.child('images');

                                              Reference referenceImageToUpload =
                                                  referenceDirImages
                                                      .child(uniqueFileName);

                                              try {
                                                await referenceImageToUpload
                                                    .putFile(File(file.path));
                                                imageUrl =
                                                    await referenceImageToUpload
                                                        .getDownloadURL();
                                              } catch (error) {}
                                            },
                                            icon: Icon(Icons.add_a_photo),
                                            iconSize: 20,
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: TextFormField(
                              controller: nama,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xff858585),
                                  prefixIcon: Icon(
                                    Icons.people,
                                    size: 28,
                                  ),
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 232, 232, 232)),
                              validator: (nama) => nama!.length < 1
                                  ? "Nama tidak boleh kosong"
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: TextFormField(
                              controller: telepon,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xff858585),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    size: 28,
                                  ),
                                  hintText: "Nomor Hp",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 232, 232, 232)),
                              validator: (telepon) => telepon!.length < 1
                                  ? "Nomor telepon tidak boleh kosong"
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: TextFormField(
                              controller: alamat,
                              maxLines: null,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 20),
                                  prefixIconColor: Color(0xff858585),
                                  prefixIcon: Icon(
                                    Icons.map_sharp,
                                    size: 28,
                                  ),
                                  hintText: "Alamat",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 232, 232, 232)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: SizedBox(
                              width: 180,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    // if (imageUrl.isEmpty) {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(SnackBar(
                                    //           content: Text(
                                    //               "Please upload an image")));
                                    //   return;
                                    // }
                                    final userData = UserModel(
                                        nama: nama.text.trim(),
                                        email: email,
                                        password: passwordd,
                                        alamat: alamat.text.trim(),
                                        telepon: telepon.text.trim(),
                                        role: "user",
                                        photo: imageUrl);
                                    if (_formKey.currentState!.validate()) {
                                      controller.updateRecord(userData,
                                          idd.toString(), context, namas);
                                    }
                                    ;

                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => home(
                                    //             currentIndex: currentIndex)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFF58244),
                                      side: BorderSide.none,
                                      shape: StadiumBorder()),
                                  child: Text(
                                    "Save",
                                  )),
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
                      child: Text('Something went wrong'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
