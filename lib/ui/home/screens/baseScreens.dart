import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';
import 'package:meetyarah/ui/home/screens/feed_screen.dart';

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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "FACEBOOK",
                      style: GoogleFonts.bebasNeue(  // ✅ font name
                        fontSize: 30,
                        color: ColorPath.deepBlue,
                        fontWeight: FontWeight.w600,
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
                    indicatorColor: ColorPath.deepBlue,
                    // ইন্ডিকেটরের রঙ
                    indicatorWeight: 3.0,
                    physics: NeverScrollableScrollPhysics(),
                    tabs: [
                      Tab(icon: Icon(Icons.home_outlined,size: 30,)),
                      Tab(icon: Icon(Icons.explore_outlined,size: 30)),
                      Tab(icon: Icon(Icons.add_box_outlined,size: 30)),
                      Tab(icon: Icon(Icons.person_outline,size: 30)),
                      Tab(icon: Icon(Icons.insights,size: 30)),
                      Tab(icon: Icon(Icons.apps,size: 30)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FeedScreen(),
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
      ),
    );
  }
}
