import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';

class Basescreens extends StatefulWidget {
  const Basescreens({super.key});

  @override
  State<Basescreens> createState() => _BasescreensState();
}

class _BasescreensState extends State<Basescreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "SImple World",
                  style: TextStyle(
                    color: ColorPath.deepBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorPath.softGray,
                      child: IconButton(onPressed: (){},
                          icon: Icon(Icons.search,
                            color: Colors.black,
                          size: 24,
                          )),
                    ),
                    CircleAvatar(
                      backgroundColor: ColorPath.softGray,
                      child: IconButton(onPressed: (){},
                          icon: Icon(Icons.sms,
                            color: Colors.black,
                            size: 24,
                          )),
                    ),

                  ],
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}
