import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: SizedBox(
            width: width * .95,
            height: height * .7,
            child: Padding(padding: const EdgeInsets.all(8.0), child: child),
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('اغلاق'))
    ]);
  }
}
