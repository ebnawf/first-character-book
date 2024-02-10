import '../components/navigation_button_widget.dart';
import '../tools/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 250),
      color: backgroundColor,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 70),
        children: const [
          NavigationButtonWidget(
            url:
                'https://www.facebook.com/people/Ibraheem-Abdewahid-Elkhateeb/100011932279349/',
            image: 'assets/images/f.png',
          ),
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
            url: 'https://youtube.com/@ibrahim_elkhateeb',
            image: 'assets/images/y.jpg',
          ),
          NavigationButtonWidget(
            url: 'mailto:ami19751980@gmail.com',
            image: 'assets/images/g.jpg',
          ),
          NavigationButtonWidget(
            url: 'https://www.tiktok.com/@ibraheem.abdewahi',
            image: 'assets/images/tk.jpg',
          ),
          NavigationButtonWidget(
            url: 'https://ibrahimelkhateeb.net',
            image: 'assets/images/b.jpg',
          ),
          NavigationButtonWidget(
            url: 'https://t.me/silsilat_laytani_wasalt',
            image: 'assets/images/tl.jpg',
          ),
          NavigationButtonWidget(
            url: 'https://whatsapp.com/channel/0029Va8tmfpKbYMQqFwVOS2R',
            image: 'assets/images/w.png',
          ),
        ],
      ),
    );
  }
}
