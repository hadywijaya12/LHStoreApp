import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhstore/app/modules/cart/controllers/cart_controller.dart';
import 'package:lhstore/app/modules/home/views/home.dart';
import 'package:lhstore/app/modules/setting/views/utils.dart';
import 'package:lhstore/models/order_model.dart';
import 'package:lhstore/models/product_model.dart';

class pembayaran extends StatefulWidget {
  final id;
  final totalAmount;
  final dataNama;
  const pembayaran(
      {Key? key,
      required this.id,
      required this.totalAmount,
      required this.dataNama})
      : super(key: key);

  @override
  State<pembayaran> createState() =>
      _pembayaranState(id, totalAmount, dataNama);
}

class _pembayaranState extends State<pembayaran> {
  @override
  final id;
  final totalAmount;
  final dataNama;
  String? idOrder;
  String? imageUrl;
  Uint8List? _image;
  void selectImage() async {
    Uint8List? img = await pickImages(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  _pembayaranState(this.id, this.totalAmount, this.dataNama);

  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pembayaran",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  children: [
                    Text(
                      "Silahkan transfer sejumlah Rp. " +
                          totalAmount.toString() +
                          " ke nomor rekening 0292590162",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "A/N Rudy Hartono (BCA)",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Text(
                  "Upload bukti bayar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              _image != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: Image(
                          image: MemoryImage(_image!),
                          height: 400,
                          width: 400,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: SizedBox(
                        height: 400,
                        width: 400,
                        child: Image(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/lhstore-80597.appspot.com/o/images%2Fnoimagee.png?alt=media&token=e42bd554-78d7-4f64-905a-90e85f3f4ec5"),
                          height: 400,
                          width: 400,
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: selectImage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF58244),
                          side: BorderSide.none,
                          shape: StadiumBorder()),
                      child: Text(
                        "Pilih Foto",
                      )),
                ),
              ),
              StreamBuilder(
                  stream: controller.getIdOrder(id),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;

                      for (var i = 0; i < data.length; i++) {
                        idOrder = data[i].id;
                      }
                      return Container();
                    } else {
                      return Container();
                    }
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        String uniqueFileName =
                            "Bukti bayar " + dataNama + " id: " + id.toString();
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('buktibayar');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          if (_image == null) {
                            const snackbar = SnackBar(
                                content: Text("Pilih foto untuk diupload!"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            await referenceImageToUpload.putData(_image!);
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();

                            await controller.clearCart();
                            await controller.getIdOrder(id);
                            if (idOrder == null) {
                              print("idOrder tidak ditemukan");
                            } else {
                              await controller.updateOrder(imageUrl, idOrder);
                              const snackbar = SnackBar(
                                  content: Text("Transaksi berhasil!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              await Get.offAll(home(currentIndex: 2));
                            }
                          }
                        } catch (error) {
                          print(error);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF58244),
                          side: BorderSide.none,
                          shape: StadiumBorder()),
                      child: Text(
                        "Upload Foto",
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
