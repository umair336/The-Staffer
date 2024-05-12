import 'package:TheStafferEmployee/screens/Login/UI/login_form.dart';
import 'package:TheStafferEmployee/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:TheStafferEmployee/style/theme.dart' as Style;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as s;

class IntroPage extends StatefulWidget {

  IntroPage() : super(key: null);

  @override
  _IntroPageState createState() => _IntroPageState();
} 

class _IntroPageState extends State<IntroPage> {
  final s.FlutterSecureStorage storage =  s.FlutterSecureStorage();
  Future<void> first(String val) async {
    await storage.write(key: 'firsttime', value: val);
  }
  _IntroPageState();
  bool clicked = false;
  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }
  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 12869.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 13122.png",
            ),
          ),
        const  Padding(
            padding:  EdgeInsets.only(top: 25.0, bottom: 0.0),
            child: Text(
              'Get Your Schedule Anywhere',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ],
      ),

      body: "Let your manager know when the best times are for you to work.",

      decoration: const PageDecoration(
          pageColor: Color.fromRGBO(97, 29, 165, 1),
          bodyTextStyle: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          //     descriptionPadding: EdgeInsets.only(left: 20, right: 20),
          imagePadding: EdgeInsets.all(20)),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 12869.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 13216.png",
            ),
          ),
        const  Padding(
            padding:  EdgeInsets.only(top: 25.0, bottom: 0.0),
            child: Text(
              'Chat With Your Coworkers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
      body: "Let your manager know when the best times are for you to work.",
      decoration: const PageDecoration(
        pageColor: Color.fromRGBO(97, 29, 165, 1),
        bodyTextStyle: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 16,
        ),
        imagePadding: EdgeInsets.all(20),
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 12869.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Image.asset(
              "images/Group 13178.png",
            ),
          ),
         const Padding(
            padding:  EdgeInsets.only(top: 25.0, bottom: 0.0),
            child: Text(
              'Set Your Availability',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
      body: "Let your manager know when the best times are for you to work.",
      decoration: const PageDecoration(
          pageColor: Color.fromRGBO(97, 29, 165, 1),
          bodyTextStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
          ),
          imagePadding: EdgeInsets.all(20)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return clicked
        ? LoginForm()
        : IntroductionScreen(
            globalBackgroundColor:const Color.fromRGBO(97, 29, 165, 1),
            pages: pages,
            onDone: () {
              first('kk');
              afterIntroComplete();
            },
            onSkip: () {
              first('kk');
              afterIntroComplete();
            },
            showSkipButton: true,
            skip: const Text('Skip',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 255, 255, 1),
                )),
            next: const Icon(
              Icons.navigate_next,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            done: const Text("DONE",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 255, 255, 1),
                )),
            dotsDecorator: DotsDecorator(
                size: const Size.square(7.0),
                activeSize: const Size(20.0, 5.0),
                activeColor: Style.Colors.mainColor,
                color:const Color.fromRGBO(255, 255, 255, 1),
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          );
  }
}
