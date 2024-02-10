import 'dart:io';

import 'package:first_character_book/components/grid_card.dart';
import 'package:first_character_book/components/labled_grid.dart';
import 'package:first_character_book/screen/close_screen.dart';
import 'package:first_character_book/screen/poems_list_screen.dart';
import 'package:first_character_book/services/db_helper.dart';
import 'package:first_character_book/services/settings_repository.dart';
import 'package:first_character_book/tools/consts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/navigation_button_widget.dart';
import '../components/pdf_icon_button.dart';
import '../services/notification_service.dart';
import '../tools/colors.dart';
import 'about_screen.dart';
import 'poem_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String userName = 'Guest';
  NotificationService notificationService = NotificationService();
  toggleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  @override
  void initState() {
    onCreate();
    super.initState();
  }

  Future<void> onCreate() async {
    SettingsRepository.getUserName().then((value) {
      if (value.isEmpty) {
        SettingsRepository.showInputNameDialoge(context).then((value) {
          setState(() {
            userName = value;
          });
        });
      } else {
        setState(() {
          userName = value;
        });
      }
    });
    var details = await notificationService.flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      final id = int.parse(details.notificationResponse!.payload!);
      var poem = await DbHelper.getPoemById(id);
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PoemScreen(poem: poem)));
      }
    }
    notificationService.scheduleNew();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight =
        (size.height - kToolbarHeight - kBottomNavigationBarHeight - 32) / 2;
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        showExitMessage(context);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffoldKey,
          // resizeToAvoidBottomInset: false,
          extendBody: false,
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text(" ديوان الحرف الاول"),
            centerTitle: true,
            titleSpacing: 5.0,
            actions: const [PdfIconButton()],
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
          ),
          drawer: Drawer(
            elevation: 120.0,
            child: SafeArea(
              child: drawerList(context),
            ),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 65),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisCount: 3,
                      mainAxisExtent: itemHeight * .5,
                    ),
                    children: [
                      GridCard(
                        text: poemsAr,
                        image: "assets/images/poem.png",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PoemsList(
                                title: poemsAr,
                                isChallenge: false,
                              ),
                            ),
                          );
                        },
                      ),
                      GridCard(
                        text: "المقدمة",
                        image: "assets/images/letter.png",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) => const AboutScreen(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/intro.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          );
                        },
                      ),
                      GridCard(
                        text: "عن السلسلة",
                        image: "assets/images/series.jpg",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) => const AboutScreen(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/about.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          );
                        },
                      ),
                      GridCard(
                        text: 'تحدي الشعراء',
                        image: "assets/images/challenge.png",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PoemsList(
                                title: challengeAr,
                                isChallenge: true,
                              ),
                            ),
                          );
                        },
                      ),
                      GridCard(
                        text: "حول التطبيق",
                        image: "assets/images/info.png",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) => const AboutScreen(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/app.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          );
                        },
                      ),
                      GridCard(
                        text: "خروج",
                        image: "assets/images/exit.png",
                        onPressed: () {
                          showExitMessage(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                //flex: 2,
                child: LabledGrid(lable: 'لمتابعة جديد السلسلة', gridItems: [
                  NavigationButtonWidget(
                    url:
                        'https://whatsapp.com/channel/0029Va8tmfpKbYMQqFwVOS2R',
                    image: 'assets/images/w.png',
                  ),
                  NavigationButtonWidget(
                    url: 'https://t.me/silsilat_laytani_wasalt',
                    image: 'assets/images/tl.jpg',
                  ),
                  NavigationButtonWidget(
                    url:
                        'https://www.facebook.com/profile.php?id=61551927194308&mibextid=ZbWKwL',
                    image: 'assets/images/f.png',
                  ),
                  NavigationButtonWidget(
                    url: 'https://ibrahimelkhateeb.net',
                    image: 'assets/images/b.jpg',
                  ),
                  NavigationButtonWidget(
                    url: 'https://www.tiktok.com/@ibraheem.abdewahi',
                    image: 'assets/images/tk.jpg',
                  ),
                ]),
              ),
              const Expanded(
                //flex: 2,
                child: LabledGrid(lable: 'للتواصل مع المؤلف', gridItems: [
                  NavigationButtonWidget(
                    url:
                        'https://twitter.com/Ibrahom94477573?t=EVafiipOocJTujW1Wtz4Fg&s=09',
                    image: 'assets/images/x.jpg',
                  ),
                  NavigationButtonWidget(
                    url:
                        'https://www.instagram.com/ibrahimabdelwahidmohamed?igsh=anBmMGhka3d5MHNm',
                    image: 'assets/images/i.png',
                  ),
                  NavigationButtonWidget(
                    url:
                        'https://www.facebook.com/people/Ibraheem-Abdewahid-Elkhateeb/100011932279349/',
                    image: 'assets/images/f.png',
                  ),
                  NavigationButtonWidget(
                    url: 'https://youtube.com/@ibrahim_elkhateeb',
                    image: 'assets/images/y.jpg',
                  ),
                  NavigationButtonWidget(
                    url: 'mailto:ami19751980@gmail.com',
                    image: 'assets/images/g.jpg',
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showExitMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: ((context) => Center(
            child: SingleChildScrollView(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                          child: Text(
                        'هل تريد تأكيد الخروج',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ClosingScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'نعم',
                              style: TextStyle(fontSize: 18),
                            )),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: const Text(
                            'لا',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  ListView drawerList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: themeColor),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userName[0],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: themeColor,
          ),
          title: const Text('الرئيسية'),
          onTap: () {
            toggleDrawer();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: themeColor,
          ),
          title: const Text('تعديل إسم المستخدم'),
          onTap: () {
            SettingsRepository.showInputNameDialoge(context,
                    initValue: userName)
                .then((value) {
              setState(() {
                userName = value;
              });
            });
            toggleDrawer();
          },
        ),
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
