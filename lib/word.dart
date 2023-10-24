import 'dart:convert';

import 'dart:convert';

List<Words> wordsFromJson(String str) => List<Words>.from(json.decode(str).map((x) => Words.fromJson(x)));

String wordsToJson(List<Words> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Words {
  final int id;
  final String word;
  final String textFirst;
  final String textScnd;
  final String type;

  Words({
    required this.id,
    required this.word,
    required this.textFirst,
    required this.textScnd,
    required this.type,
  });

  factory Words.fromJson(Map<String, dynamic> json) => Words(
    id: json["id"],
    word: json["word"],
    textFirst: json["textFirst"],
    textScnd: json["textScnd"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "word": word,
    "textFirst": textFirst,
    "textScnd": textScnd,
    "type": type,
  };
}