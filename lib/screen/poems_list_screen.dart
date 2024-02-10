import 'dart:io';

import 'package:first_character_book/components/poem_tile.dart';
import 'package:first_character_book/screen/home_screen.dart';
import 'package:first_character_book/services/poem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/pdf_icon_button.dart';
import '../services/settings_repository.dart';
import '../tools/colors.dart';

class PoemsList extends StatefulWidget {
  const PoemsList({super.key, required this.title, required this.isChallenge});
  final String title;
  final bool isChallenge;
  @override
  State<PoemsList> createState() => _PoemsListState();
}

class _PoemsListState extends State<PoemsList> {
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
        extendBody: false,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          titleSpacing: 5.0,
          actions: const [PdfIconButton()],
        ),
        drawer: Drawer(
          elevation: 120.0,
          child: SafeArea(
            child: drawerList(context),
          ),
        ),
        body: Consumer<PoemProvider>(builder: (context, poemProvider, _) {
          poemProvider.selectData(isChallenge: widget.isChallenge);
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: RawScrollbar(
              thumbColor: Colors.white,
              thumbVisibility: true,
              thickness: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: SizedBox(
                  width: width * 0.80,
                  child: ListView.builder(
                    itemCount: poemProvider.poems.length,
                    itemBuilder: (context, index) {
                      return PoemTile(
                        poem: poemProvider.poems[index],
                        textColor: poemProvider.chapters
                            .firstWhere((element) =>
                                element.chapter ==
                                poemProvider.poems[index].chapter)
                            .color,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: Visibility(
          visible: widget.isChallenge,
          child: const Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'أخرج موهبة كتابة الشعر التي بداخلك، تحدي الشعراء بانتظارك!!! لا تنسى كلنا امل بمشاركة ما قمت بكتابته',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView drawerList(BuildContext context) {
    return ListView(
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
    );
  }
}
