import 'package:first_character_book/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfIconButton extends StatelessWidget {
  const PdfIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        String selectedUrl = '';
        showDialog(
          context: context,
          builder: ((context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            selectedUrl =
                                'https://www.noor-book.com/%D9%83%D8%AA%D8%A7%D8%A8-%D8%A7%D9%84%D8%AD%D8%B1%D9%81-%D8%A7%D9%84%D8%A3%D9%88%D9%84-pdf';
                            Navigator.of(context, rootNavigator: true)
                                .pop(selectedUrl);
                          },
                          child: const Text('مكتبة نور')),
                      ElevatedButton(
                          onPressed: () {
                            selectedUrl =
                                'https://foulabook.com/ar/book/%D9%83%D8%AA%D8%A7%D8%A8-%D8%A7%D9%84%D8%AD%D8%B1%D9%81-%D8%A7%D9%84%D8%A3%D9%88%D9%84-pdf';
                            Navigator.of(context, rootNavigator: true)
                                .pop(selectedUrl);
                          },
                          child: const Text('فولة بوك'))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop("");
                      },
                      child: const Text('إغلاق'))
                ],
              )),
        ).then((value) {
          if (value != null) {
            if (value.toString().isNotEmpty) {
              Uri uri = Uri.parse(value);
              canLaunchUrl(uri).then((value) =>
                  launchUrl(uri, mode: LaunchMode.externalApplication));
            }
          }
        });
      },
      icon: const Icon(
        Icons.picture_as_pdf,
        color: themeColor,
        size: 40,
      ),
    );
  }
}
