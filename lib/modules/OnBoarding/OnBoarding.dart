import 'package:flutter/material.dart';
import 'package:shop_app/modules/Login/Login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/local/cache/cache.dart';
import 'package:shop_app/shared/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingmodel {
  final String image;
  final String title;
  final String body;

  boardingmodel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var controlboarding = PageController();

  List<boardingmodel> onboardingscreens = [
    boardingmodel(
        image: 'assets/images/OnBoard.png',
        title: 'first screen title',
        body: 'first body'),
    boardingmodel(
        image: 'assets/images/OnBoarding2.png',
        title: 'second screen title',
        body: 'second body'),
    boardingmodel(
        image: 'assets/images/OnBoarding3.png',
        title: 'third screen title',
        body: 'third body')
  ];

  bool islastboard = false;
  void submit(){  if (islastboard) {
                    Cache.putdata(key: 'onBoarding', value: true).then((value) {
                      if (value!) {
                        navigatet_close(context, Login());
                      }
                    });
                    ;
                  } else {
                    controlboarding.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOut);
                  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: submit,
            child: Text(
              'Skip',
              style: TextStyle(fontSize: 24),
            ))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == onboardingscreens.length - 1) {
                  setState(() {
                    islastboard = true;
                  });
                } else {
                  setState(() {
                    islastboard = false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              controller: controlboarding,
              itemBuilder: ((context, index) =>
                  OnBoardingItem(onboardingscreens[index])),
              itemCount: onboardingscreens.length,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: SmoothPageIndicator(
                  controller: controlboarding,
                  count: onboardingscreens.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: primary_c,
                    dotColor: primary_c,
                    expansionFactor: 4,
                    dotHeight: 15,
                    dotWidth: 13,
                  ),
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: submit,
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 50,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}


Widget OnBoardingItem(boardingmodel model) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 25),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '${model.body}',
        style: TextStyle(fontSize: 20),
      )
    ]);
