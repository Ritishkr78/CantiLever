// fetch data from api

import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:news_app/model/all_news_model.dart';
import 'package:news_app/model/news_channel_headline_model.dart';
import 'package:news_app/model/categories_news_model.dart';
// import 'package:news_app/screens/all_news_screen.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=2e7d1d12fbc5425aba604925323075b7';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=2e7d1d12fbc5425aba604925323075b7';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }
}
