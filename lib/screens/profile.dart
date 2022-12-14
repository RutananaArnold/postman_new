import 'package:flutter/material.dart';
import 'package:postman/controllers/Globals.dart';
import 'package:postman/models/User.dart';
import 'package:postman/widgets/profile_tile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? usr = "";
  getUser() async {
    usr = await global.getValue("user");
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    User userProfile = userFromJson("$usr");

    List user = [
      {"name": "Date Of Birth", "text": userProfile.user?.profile.dob},
      {"name": "Gender", "text": userProfile.user?.profile.gender},
      {"name": "Phone", "text": userProfile.user?.profile.phone},
      {"name": "Businnes Name", "text": userProfile.customer?.businessName},
      {"name": "Email", "text": userProfile.user?.customer.email},
    ];

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(children: [
          //top card
          Transform.rotate(
            angle: (60 / 180),
            origin: Offset(size.width * 2.4, size.height * -0.1),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: size.height * 0.65,
              width: size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: size.height * 0.003,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(200),
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.red[100],
                        foregroundImage:
                            const AssetImage("assets/demoLogo.png"),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      //"${userProfile.user?.firstName}   ${userProfile.user?.lastName}",
                      userProfile.user!.username,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      userProfile.user!.email,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          user.length,
                          (index) => ProfileTile(
                              padding: 20,
                              label: user[index]['name'],
                              value: user[index]['text']),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // RoundedButton(text: "Edit", press: () {}, color: Colors.red)
        ]),
      ),
    );
  }
}
