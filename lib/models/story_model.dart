class Story {

  final int id;
  final String title;
  final String by;
  final int score;
  final List<dynamic>? kids;
  final String? text;

  Story({
    required this.id,
    required this.title,
    required this.by,
    required this.score,
    this.kids,
    this.text,
  });

  factory Story.fromJson(Map<String, dynamic> json) {

    return Story(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      by: json['by'] ?? '',
      score: json['score'] ?? 0,
      kids: json['kids'],
      text: json['text'],
    );
  }
}