import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../tools/text_style.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: HomePage(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 243, 247),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Expanded(child: SizedBox()),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 7),
                    child: Center(
                      child: Image(
                        image: const AssetImage('assets/images/playstore.png'),
                        height: height * 0.5,
                        width: width * 0.8,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Center(
                      child: DefaultTextStyle(
                        style: splashStyle,
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText("سلسلة ليتني واصلت",
                                speed: const Duration(milliseconds: 100)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Maria Tech© 2024"),
                    Text("v 1.0"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
