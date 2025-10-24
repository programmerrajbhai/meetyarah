import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';
import 'package:meetyarah/ui/home/screens/feed_screen.dart';

import '../../reels/screens/reel_screens.dart';

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
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "FACEBOOK",
                    style: GoogleFonts.bebasNeue(  // ✅ font name
                      fontSize: 30,
                      color: ColorPath.deepBlue,
                      fontWeight: FontWeight.w200,
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
                            size: 20,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: ColorPath.softGray,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.sms, color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: ColorPath.deepBlue,
                  indicatorWeight: 3.0,
                  physics: NeverScrollableScrollPhysics(),
                  tabs: [
                    Tab(icon: Icon(Icons.home_outlined,size: 24,)),
                    Tab(icon: Icon(Icons.play_circle_fill,size: 24)),
                    Tab(icon: Icon(Icons.add_box_outlined,size: 24)),
                    Tab(icon: Icon(Icons.person_outline,size: 24)),
                    Tab(icon: Icon(Icons.insights,size: 24)),
                    Tab(icon: Icon(Icons.apps,size: 24)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FeedScreen(),
                    ReelScreens(),
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
