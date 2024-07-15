// import 'package:flutter/foundation.dart';
import 'package:news_app/model/news_channel_headline_model.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/model/categories_news_model.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
