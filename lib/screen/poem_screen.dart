import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_character_book/models/poem_model.dart';
import 'package:first_character_book/screen/poems_list_screen.dart';
import 'package:first_character_book/services/db_helper.dart';
import 'package:first_character_book/services/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/pdf_icon_button.dart';
import '../tools/colors.dart';
import '../tools/consts.dart';
import '../tools/text_style.dart';
import 'home_screen.dart';

class PoemScreen extends StatefulWidget {
  const PoemScreen({super.key, required this.poem});
  final Poem poem;

  @override
  State<PoemScreen> createState() => _PoemScreenState();
}

class _PoemScreenState extends State<PoemScreen> {
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
    //Delete poem from suggetsted table
    DbHelper.delete(suggestedPoemsTable, widget.poem.id);
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            ' باب (${widget.poem.chapter}) ',
          ),
          centerTitle: true,
          titleSpacing: 5.0,
          actions: const [PdfIconButton()],
        ),
        drawer: Drawer(
          elevation: 120.0,
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
                    Icons.menu_book,
                    color: themeColor,
                  ),
                  title: const Text(poemsAr),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PoemsList(
                          title: poemsAr,
                          isChallenge: false,
                        ),
                      ),
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
                    String url, packageName = '';
                    packageName = await SettingsRepository.getPackageName();
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
            ),
          ),
        ),
        body: Card(
          margin: EdgeInsets.all(width * .03),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(
                width: 3.0,
                color: themeColor,
              )),
          elevation: 1.0,
          color: Colors.white,
          child: Container(
            constraints: BoxConstraints(minWidth: width * 0.95),
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
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Center(
                                child: AutoSizeText(widget.poem.text,
                                    maxLines: 150,
                                    style: paragraphStyle,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    minFontSize: 25,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
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
