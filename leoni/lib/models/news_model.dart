class NewsModel {
  final int id;
  final String title;
  final String category;
  final String date;
  final String content;
  final String imageUrl;
  late bool isSaved = false;

  NewsModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.content,
    this.imageUrl = "assets/images/news_placeholder.png",
    this.isSaved = false,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      date: json['date'],
      content: json['content'],
      imageUrl: json['imageUrl'] ?? "assets/images/news_placeholder.png",
    );
  }
} 