import 'package:first_character_book/models/poem_model.dart';
import 'package:first_character_book/screen/challenge_screen.dart';
import 'package:first_character_book/screen/poem_screen.dart';
import 'package:flutter/material.dart';

class PoemTile extends StatelessWidget {
  const PoemTile({super.key, required this.poem, required this.textColor});
  final Poem poem;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return Card(
      child: InkWell(
        onTap: () {
          poem.chapter != "100"
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PoemScreen(poem: poem)))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChallengeScreen(poem: poem)));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                tileColor: textColor,
                title: Center(
                  child: Text(
                    poem.title,
                    style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
