import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../models/onboarding/onboardModel.dart';
import '../login/signin.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreen createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  int activeIndex = 0;
  List<MyItem> items = [
    MyItem("user vehicle speed prediction",'assets/images/page-1/onboard/black.png'),
    MyItem("user meeting time prediction", 'assets/images/page-1/onboard/twi.png'),
    MyItem("traffic light timing", 'assets/images/page-1/onboard/bla.png'),
    MyItem("show user traffic at those places", 'assets/images/page-1/onboard/wats.png'),
    MyItem("best path for traffic", 'assets/images/page-1/onboard/plate.png'),
    MyItem("Determining Road Conditions", 'assets/images/page-1/onboard/mappls.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(200, 12, 12, 12),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),

          CarouselSlider.builder(
            itemCount: items.length,
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: const Duration(seconds: 2),
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final imgList = items[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: buildImage(imgList.path, index)),
                  const SizedBox(
                    height: 15,
                  ),
                  buildText(imgList.itemName, index),
                ],
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 100, // <-- Your width
            height: 50, // <-- Your height
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SignIn(),
                  ),
                );
              },
              child: const Text("Get Started ->"),
            ),
          ),

          //buildText(itemName, index),
          // buildText(),
        ],
      ),
    );
  }

  Widget buildImage(String imgList, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.black,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            imgList,
            fit: BoxFit.cover,
          ),
        ),
      );

  // buildIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: items.length,
  //       effect: const JumpingDotEffect(
  //           dotColor: Colors.black,
  //           dotHeight: 15,
  //           dotWidth: 15,
  //           activeDotColor: Colors.red),
  //     );

  buildText(String itemName, int index) => Align(
      alignment: FractionalOffset.bottomCenter,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 23, color: Colors.white),
        child: Text(itemName),
      ));
}
