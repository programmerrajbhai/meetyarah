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
    return DefaultTabController(
      length: 6,
      child: Scaffold(
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
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: ColorPath.softGray,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.sms, color: Colors.black, size: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: TabBar(
                  labelColor: Colors.black,
                  // সিলেক্টেড ট্যাবের লেখার রঙ
                  unselectedLabelColor: Colors.black,
                  // অন্যান্য ট্যাবের লেখার রঙ
                  indicatorColor: ColorPath.softGray,
                  // ইন্ডিকেটরের রঙ
                  indicatorWeight: 3.0,
                  tabs: [
                    Tab(icon: Icon(Icons.home_outlined)),
                    Tab(icon: Icon(Icons.explore_outlined)),
                    Tab(icon: Icon(Icons.add_box_outlined)),
                    Tab(icon: Icon(Icons.person_outline)),
                    Tab(icon: Icon(Icons.insights)),
                    Tab(icon: Icon(Icons.apps)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Text("SCreens 1"),
                    Text("SCreens 2"),
                    Text("SCreens 3"),
                    Text("SCreens 4"),
                    Text("SCreens 5"),
                    Text("SCreens 6"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
