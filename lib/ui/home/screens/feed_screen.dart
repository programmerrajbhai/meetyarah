import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 170,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            "https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?_gl=1*h0k086*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjg2MTUkbzQkZzEkdDE3NjEwNjg2MjUkajUwJGwwJGgw", // তোমার ছবির path
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Plus icon in blue circle
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 20),
                        ),

                        const SizedBox(height: 6),

                        // Text
                        const Text(
                          "Create story",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 170,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16),bottom: Radius.circular(16)),
                          child: Image.network(
                            "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?_gl=1*1hs44no*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjExNDg5ODAkbzYkZzAkdDE3NjExNDg5ODAkajYwJGwwJGgw", // তোমার ছবির path
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Text
                        Align(alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            const Text(
                              "João Jesus ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10), // Border এর প্রস্থ নিয়ন্ত্রণ
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue, // বর্ডারের রঙ
                            width:0,           // বর্ডারের পুরুত্ব
                          ),
                        ),
                        child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage('https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?_gl=1*h0k086*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjg2MTUkbzQkZzEkdDE3NjEwNjg2MjUkajUwJGwwJGgw')
                          //child: Image.network('https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?_gl=1*h0k086*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjg2MTUkbzQkZzEkdDE3NjEwNjg2MjUkajUwJGwwJGgw'),
                        ),
                      ),

                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2,),
                          Text("GEORAGE LOBKO",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),

                          Text("2 hours age",
                            style: TextStyle(
                                color: Colors.grey
                            ),),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 2,),
                      Container(
                        padding: EdgeInsets.all(10), // Border এর প্রস্থ নিয়ন্ত্রণ
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue, // বর্ডারের রঙ
                            width: 1,           // বর্ডারের পুরুত্ব
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: AssetImage(ImagePath.two_dot),
                        ),
                      )



                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    child:Text("Hi Everyone. today i was on the most "
                        "beautifull mountain in the world , I also want to say "
                        "hi to Sliena , Olia, Davis! ",
                      style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold,
                      ),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // কোণাগুলো curve করবে
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?_gl=1*g1tjot*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjU3ODAkbzMkZzAkdDE3NjEwNjU3ODAkajYwJGwwJGgw",
                        ),
                        fit: BoxFit.cover, // পুরো container ভরবে
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPath.softGray,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: IconButton(onPressed: (){},
                                  icon: Icon(Icons.heart_broken),),
                              ),
                              SizedBox(width: 10,),
                              Text("299k+ ",style:TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ), )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPath.softGray,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: IconButton(onPressed: (){},
                                  icon: Icon(Icons.comment),),
                              ),
                              SizedBox(width: 10,),
                              Text("109k+ ",style:TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ), )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPath.softGray,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: IconButton(onPressed: (){},
                                  icon: Icon(Icons.share),),
                              ),
                              SizedBox(width: 10,),
                              Text("59k+ ",style:TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ), )
                            ],
                          ),
                        ),
                      )



                    ],
                  )

                ],
              )
            ],
          ),
        ),
      )),

    );
  }
}
