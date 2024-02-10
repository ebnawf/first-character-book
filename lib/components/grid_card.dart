import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../tools/text_style.dart';

class GridCard extends StatelessWidget {
  const GridCard(
      {super.key, required this.text, required this.image, this.onPressed});
  final String text;
  final String image;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          //margin: const EdgeInsets.all(5),
          // padding: const EdgeInsets.all(10),
          child: Stack(
            //fit: StackFit.passthrough,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Card(
                        elevation: 10,
                        child: Image.asset(
                          image,
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: AutoSizeText(
                          text,
                          style: chapterStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          maxFontSize: 18,
                          minFontSize: 10,
                        ),
                      ),
                    ),
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
