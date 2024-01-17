import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lhstore/app/modules/setting/views/edit_profile.dart';
import 'package:lhstore/models/user_model.dart';
import 'package:lhstore/service/auth_service.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return settings();
  }
}

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final controller = SettingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(22, 45, 20, 0),
                    child: Row(
                      children: [
                        Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
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
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(userData.photo ??
                            "https://img.freepik.com/free-vector/illustration-camera-icon_53876-5563.jpg?w=740&t=st=1701882732~exp=1701883332~hmac=9f8d2dbf40cf010cad3a7a4bba6ed5e3dd6b35b40d039e9ded35c2c7bdc3263a"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text(
                      userData.nama.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Text(
                      userData.email.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              var nama = "no";
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        editProfile(namas: nama)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF58244),
                                side: BorderSide.none,
                                shape: StadiumBorder()),
                            child: Text(
                              "Edit Profile",
                            )),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  listSettings(
                    title: "Privasi",
                    icon: Icons.private_connectivity,
                    onPress: () {},
                  ),
                  listSettings(
                    title: "Bantuan",
                    icon: Icons.help_center_rounded,
                    onPress: () {},
                  ),
                  listSettings(
                    title: "Log Out",
                    icon: Icons.logout_rounded,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () => controller.logout(),
                  ),
                ],
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
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: 300,
                ),
                CircularProgressIndicator()
              ],
            ));
          }
        },
      ),
    );
  }
}

class listSettings extends StatelessWidget {
  const listSettings(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.endIcon = true,
      this.textColor});

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xFFF58244).withOpacity(0.1)),
          child: Icon(
            icon,
            color: Color(0xffF58244),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700).apply(color: textColor),
        ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
