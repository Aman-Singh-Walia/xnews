import 'package:flutter/cupertino.dart';
import 'package:xnews/data/news_api_key.dart';
import 'package:xnews/models/article_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticlesProvider extends ChangeNotifier {
  List<Article> articlesList = [];
  int currentPage = 1;
  bool isloadingMoreArticles = false;

  Future fetchMoreArticles(int page) async {
    List<Article> nextPageArticles = [];
    currentPage = page;
    isloadingMoreArticles = true;
    notifyListeners();
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?&q=world&page=$page&apiKey=$newsApiKey');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      List<dynamic> articlesJsonData = jsonData['articles'];
      for (var element in articlesJsonData) {
        nextPageArticles.add(Article(
            title: element['title'] ?? 'No title',
            author: element['author'] ?? 'Unknown',
            description: element['description'] ?? 'No description',
            url: element['url'] ?? 'null',
            urlToImg: element['urlToImage'] ?? 'null'));
      } //loop through articles json data

      articlesList.addAll(nextPageArticles);
      isloadingMoreArticles = false;
      notifyListeners();
    } else {
      isloadingMoreArticles = false;
      notifyListeners();
    }
  } //fetch more articles
}
