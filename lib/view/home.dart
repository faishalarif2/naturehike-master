import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/view/barang.dart';
import 'package:naturehike/view/peminjam.dart';

import '../model/user_model.dart';

class Home extends StatelessWidget {
  final UserModel loggedInUser;
  final AuthController authController = AuthController();

  Home({required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hii ",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 255, 17, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: loggedInUser.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/images/person.png",
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome Admin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cabang Toko Daerah ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: loggedInUser.cabang,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Image.asset("assets/images/background.png"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose Your Feature"),
                        SizedBox(height: 5),
                        Container(
                          width: 60,
                          height: 4,
                          color: Color.fromARGB(255, 0, 242, 81),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Category(
                      color: Color.fromARGB(255, 0, 154, 59),
                      imgurl: "assets/images/tools.png",
                      caption: "List Alat Hiking",
                    ),
                    CategoryLeft(
                      color: Color.fromARGB(255, 0, 214, 36),
                      imgurl: "assets/images/camping.png",
                      caption: "Peminjam Alat Hiking",
                    ),
                  ],
                ),
                SizedBox(height: 150),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        
                        onPressed: () {
                          // Call logout function from auth controller
                          authController.signOut();
                          // Navigate to login page
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final Color color;
  final String imgurl;
  final String caption;
  const Category({
    super.key,
    required this.color,
    required this.imgurl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Barang()));
      },
      child: Container(
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgurl,
              width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                caption,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryLeft extends StatelessWidget {
  final Color color;
  final String imgurl;
  final String caption;
  const CategoryLeft({
    super.key,
    required this.color,
    required this.imgurl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Peminjam()));
      },
      child: Container(
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgurl,
              width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                caption,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
