import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_character_book/models/poem_model.dart';
import 'package:first_character_book/services/poem_provider.dart';
import 'package:first_character_book/services/settings_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/pdf_icon_button.dart';
import '../services/share_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/floating_button.dart';
import '../components/stack_text_field.dart';
import '../tools/colors.dart';
import '../tools/consts.dart';
import '../tools/text_style.dart';
import 'home_screen.dart';
import 'poems_list_screen.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key, required this.poem});
  final Poem poem;

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.poem.title),
          centerTitle: true,
          titleSpacing: 10.0,
          actions: const [PdfIconButton()],
        ),
        drawer: Drawer(
          elevation: 120,
          child: SafeArea(
              child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: themeColor,
                ),
                title: const Text('الرئيسية'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                  toggleDrawer();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.edit_document,
                  color: themeColor,
                ),
                title: const Text(challengeAr),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PoemsList(
                              title: challengeAr,
                              isChallenge: true,
                            )),
                  );
                  toggleDrawer();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.star_rate,
                  color: themeColor,
                ),
                title: const Text('قيم التطبيق'),
                onTap: () async {
                  String url;
                  String packageName =
                      await SettingsRepository.getPackageName();
                  if (Platform.isAndroid) {
                    url =
                        'https://play.google.com/store/apps/details?id=$packageName';
                  } else if (Platform.isIOS) {
                    url =
                        'https://apps.apple.com/app/id$packageName'; // Replace with your iOS app ID
                  } else {
                    throw 'Unsupported platform';
                  }
                  Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ],
          )),
        ),
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Card(
                    margin: EdgeInsets.all(width * .03),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          width: 4.0,
                          color: themeColor,
                        )),
                    elevation: 1.0,
                    color: Colors.white,
                    child: Container(
                      //  constraints: BoxConstraints(maxHeight: height * 0.78),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: AssetImage(backgroundImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(widget.poem.text,
                                          maxLines: 6,
                                          style: paragraphStyle,
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          minFontSize: 18,
                                          overflow: TextOverflow.ellipsis),
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
                Expanded(
                    flex: 8,
                    child: StackedTextField(
                      initialText: widget.poem.comment!,
                      hintText: 'أكتب قصيدة متضمنة البيت أو الابيات اعلاه',
                      onChanged: (value) {
                        widget.poem.comment = value;
                        Provider.of<PoemProvider>(context, listen: false)
                            .updatePoem(widget.poem);
                      },
                      positionedButtons: [
                        FloatingButton(
                          child: const Image(
                            image: AssetImage("assets/images/simage.png"),
                            height: 35,
                            width: 35,
                          ),
                          onPressed: () {
                            ShareService.convertToImageAndShare(
                                widget.poem, context,
                                fromUsers: true);
                          },
                        ),
                        FloatingButton(
                          child: const Image(
                            image: AssetImage("assets/images/w.png"),
                            height: 35,
                            width: 35,
                          ),
                          onPressed: () {
                            String userName = '';
                            SettingsRepository.getUserName().then((value) {
                              userName = value;
                              String text =
                                  'إضافتي على قصيدة - ${widget.poem.title} - ${widget.poem.text.substring(0, 15)} .... \r\n _______________________\r\n ${widget.poem.comment!} \r\n _______________________\r\n $userName';
                              ShareService.shareWithAuthor(text);
                            });
                          },
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
