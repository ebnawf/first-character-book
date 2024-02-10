import 'dart:io';
import 'package:first_character_book/models/poem_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/screen_shot_widget.dart';
import '../tools/colors.dart';
import '../tools/consts.dart';
import '../tools/text_style.dart';

class ShareService {
  static const String authorPhone = '249912270717';

  static void shareWithAuthor(String text) async {
    String whatsappUrl =
        "https://wa.me/$authorPhone?text=${Uri.encodeFull(text)}";

    Uri uri = Uri.parse(whatsappUrl);
    canLaunchUrl(uri)
        .then((value) => launchUrl(uri, mode: LaunchMode.externalApplication));
  }

  static Future<ShareResult> shareImage(
      File file, String subject, String text) async {
    return await Share.shareXFiles(
      [XFile(file.path)],
      subject: subject,
      text: text,
    );
  }

  static Future<void> convertToImageAndShare(Poem poem, BuildContext context,
      {bool fromUsers = false}) async {
    ScreenshotController screenshotController = ScreenshotController();
    screenshotController
        .captureFromWidget(
            SingleChildScrollView(
                child: SharedCompnents.screenshotWidget(
                    '${poem.comment}', 'تحدي الشعراء',
                    title: poem.title, fromUsers: fromUsers)),
            delay: const Duration(milliseconds: 100),
            context: context)
        .then(
      (imageUint8List) async {
        final directory = (await getTemporaryDirectory()).path;
        final imagePath = await File('$directory/${poem.id}.png').create();
        await imagePath.writeAsBytes(imageUint8List);
        await ShareService.shareImage(
            imagePath, '${poem.id}.png', '(الحرف الاول- تحدي الشعراء)');
        //- ${fromUsers ? 'مشاركة القراء' : ""}
      },
    );
  }

  static Widget screenshotWidget(String text, String author) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                'تذكر دائماً ...',
                style: titleStyle,
                textDirection: TextDirection.rtl,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(text,
                    maxLines: 10,
                    style: paragraphStyle,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  author,
                  style: authorStyle,
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
