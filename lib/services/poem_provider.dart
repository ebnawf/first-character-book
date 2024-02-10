import 'package:first_character_book/models/chapter_details.dart';
import 'package:first_character_book/models/poem_model.dart';
import 'package:first_character_book/tools/colors.dart';
import 'package:first_character_book/tools/consts.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class PoemProvider extends ChangeNotifier {
  List<Poem> poems = [];
  List<ChapterDetails> chapters = [];
  Future<void> selectData({bool isChallenge = false}) async {
    poems = await DbHelper.getPoemList();
    if (isChallenge) {
      poems.removeWhere(
        (element) => element.chapter != "100",
      );
    } else {
      poems.removeWhere(
        (element) => element.chapter == "100",
      );
    }
    await getChapters();
    notifyListeners();
  }

  Future getChapters() async {
    var chaptersName = await DbHelper.getChaptersList();
    for (var i = 0; i < chaptersName.length; i++) {
      Color color = i >= chaptersColors.length ? Colors.red : chaptersColors[i];
      chapters.add(ChapterDetails(chapter: chaptersName[i], color: color));
    }
  }

  void updatePoem(Poem poem) async {
    await DbHelper.update(poemTable, 'comment', poem.comment!, poem.id);
  }

  Future<Poem> getPoem(int id) async {
    return await DbHelper.getPoemById(id);
  }
}
