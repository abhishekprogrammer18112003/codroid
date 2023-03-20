import 'package:codroid/constants/images.dart';
import 'package:codroid/mobile/m_main_screen/codeforces.dart';
import 'package:flutter/material.dart';

import 'image_slide.dart';

class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({Key? key}) : super(key: key);

  @override
  _MobileMainScreenState createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  void opencodeforcespage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CodeforcesPage()));
  }

  void opencodechefpage() {}
  void openleetcodepage() {}
  void opencodingninjaspage() {}
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // color: Colors.black,
                height: 200,
                child: ImageSlider(
                  imageUrls: [
                    // 'https://1.bp.blogspot.com/-kK7Fxm7U9o0/YN0bSIwSLvI/AAAAAAAACFk/aF4EI7XU_ashruTzTIpifBfNzb4thUivACLcBGAsYHQ/s1280/222.jpg',
                    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014__340.jpg',
                    'https://cdn.pixabay.com/photo/2020/04/11/08/26/lake-5029360__480.jpg',
                    'https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg',
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //codeforces
                  GestureDetector(
                    onTap: opencodeforcespage,
                    child: Card(
                      elevation: 5, // Shadow depth
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16), // Inner padding
                          child: Stack(
                            children: [Center(child: Image.asset(codeforces))],
                          )),
                    ),
                  ),

                  //codechef
                  GestureDetector(
                    child: Card(
                      elevation: 5, // Shadow depth
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16), // Inner padding
                          child: Stack(
                            children: [Center(child: Image.asset(codechef))],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //lettcode
                  GestureDetector(
                    child: Card(
                      elevation: 5, // Shadow depth
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16), // Inner padding
                          child: Stack(
                            children: [Center(child: Image.asset(leetcode))],
                          )),
                    ),
                  ),

                  //codingninjas
                  GestureDetector(
                    child: Card(
                      elevation: 5, // Shadow depth
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16), // Inner padding
                          child: Stack(
                            children: [
                              Center(child: Image.asset(codingninjas))
                            ],
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
