class Poem {
  late int id;
  late String text;
  late String title;
  late String? comment;
  final String? chapter;
  // late bool isRead;
  Poem.fromMap(Map<dynamic, dynamic> data)
      : id = data['Id'],
        title = data['title'],
        text = data['text'] ?? '',
        chapter = data['chapter'] ?? '',
        //  isRead = data['isRead'] == 0 ? false : true,
        comment = data['comment'] ?? '';

  Map<String, Object> toMap() {
    return {
      'Id': id,
      'text': text,
      'title': title,
      //'isRead': isRead,
      'chapter': chapter!,
      'comment': comment!,
    };
  }
}
