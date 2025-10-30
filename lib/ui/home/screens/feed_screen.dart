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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),

                //Story
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // প্রথম Card: Create Story
                        Container(
                          width: 150,
                          height: 200,
                          margin: const EdgeInsets.only(right: 10),
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
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  "https://scontent.fdac179-1.fna.fbcdn.net/v/t39.30808-6/567677708_788823450696325_5639549844313816125_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHH_0pUcly0NO-JWLs3TN4RRpilTbjywadGmKVNuPLBp3KC177Yr7gvJqHvML4mSvd9Tin2vJkLJ71pLr5JysTs&_nc_ohc=0WcSrHaCjPgQ7kNvwFqm4a_&_nc_oc=AdkHOqa2oPZQ1cUVh5SPp25vr6JYq6GfNGecGSrMi0Kk1LA6__cXocL_eEqmHg0yeBk&_nc_zt=23&_nc_ht=scontent.fdac179-1.fna&_nc_gid=YgzxjqSoJiRyR8gWHyktMA&oh=00_AffLG1W_SD6jkyrNCpOg1_OwO_aHtYNf5QL93dXHm6S6WQ&oe=690803AF",
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              const Text(
                                "Create story",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        ...List.generate(30, (index) {
                          return Container(
                            width: 150,
                            height: 200,
                            margin: const EdgeInsets.only(right: 10),
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
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg",
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "João Jesus ${index + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //Post Items
                ListView.builder(
                  itemCount: 30,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                10,
                              ), // Border এর প্রস্থ নিয়ন্ত্রণ
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?_gl=1*h0k086*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjg2MTUkbzQkZzEkdDE3NjEwNjg2MjUkajUwJGwwJGgw',
                                ),
                                //child: Image.network('https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?_gl=1*h0k086*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjg2MTUkbzQkZzEkdDE3NjEwNjg2MjUkajUwJGwwJGgw'),
                              ),
                            ),

                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2),
                                Text(
                                  "GEORAGE LOBKO",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Text(
                                  "2 hours age",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.all(
                                10,
                              ), // Border এর প্রস্থ নিয়ন্ত্রণ
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black , // বর্ডারের রঙ
                                  width: 1, // বর্ডারের পুরুত্ব
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundImage: AssetImage(ImagePath.two_dot),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            "Hi Everyone. today i was on the most "
                            "beautifull mountain in the world , I also want to say "
                            "hi to Sliena , Olia, Davis! ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // কোণাগুলো curve করবে
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?_gl=1*g1tjot*_ga*MTcxMzA4Nzk4OS4xNzM0ODg2OTE0*_ga_8JE65Q40S6*czE3NjEwNjU3ODAkbzMkZzAkdDE3NjEwNjU3ODAkajYwJGwwJGgw",
                              ),
                              fit: BoxFit.cover, // পুরো container ভরবে
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: ColorPath.softGray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.heart_broken_outlined,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "100k+ ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: ColorPath.softGray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.comment, size: 15),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "40k+ ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: ColorPath.softGray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share, size: 15),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "30k+ ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
