import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:news_app/model/news_article.dart';

class Webservice {
  Future<List<NewsArticle>> fetchTopHeadLines() async {
    String url =
        'https://newsapi.org/v2/everything?q=general&apiKey=2e7d1d12fbc5425aba604925323075b7';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      throw Exception('failed to load Khabar');
    }
  }
}
