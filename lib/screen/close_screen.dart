import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import '../tools/text_style.dart';
import 'package:flutter/material.dart';

class ClosingScreen extends StatefulWidget {
  const ClosingScreen({super.key});

  @override
  State<ClosingScreen> createState() => _ClosingScreenState();
}

class _ClosingScreenState extends State<ClosingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        image: const AssetImage('assets/images/closing.jpg'),
                        height: height * 0.8,
                        width: width * .9,
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
                              TyperAnimatedText("شكرا لاستخدامك التطبيق",
                                  speed: const Duration(milliseconds: 100)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
