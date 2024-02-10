import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../tools/colors.dart';
import '../tools/consts.dart';
import '../tools/text_style.dart';

class SharedCompnents {
  static Widget screenshotWidget(String text, String chapter,
      {String title = 'تذكر دائماً ...', bool fromUsers = false}) {
    return Card(
      // margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            width: 5.0,
            color: themeColor,
          )),
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: const DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'سلسلة ليتني واصلت',
                        style: footerStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      const Text(
                        'ديوان الحرف الاول',
                        style: footerStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        chapter,
                        style: footerStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: titleStyle,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AutoSizeText(text,
                        maxLines: 45,
                        style: paragraphStyle,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        minFontSize: 10,
                        maxFontSize: 25,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Visibility(
                  visible: fromUsers,
                  child: const Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'المؤلف: إبراهيم عبدالواحد الخطيب',
                            style: footerStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            'مشاركة القراء',
                            style: footerStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
