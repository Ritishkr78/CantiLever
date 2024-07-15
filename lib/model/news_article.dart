import 'package:flutter/cupertino.dart';

class NewsArticle extends StatelessWidget {
  const NewsArticle(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.url,
      required this.publishedAt,
      required this.source,
      super.key});

  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String source;
  factory NewsArticle.fromJSON(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      source: json['source'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
