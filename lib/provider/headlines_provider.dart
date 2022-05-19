import 'package:flutter/cupertino.dart';
import 'package:xnews/data/news_api_key.dart';
import 'package:xnews/models/headline_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HeadlinesProvider extends ChangeNotifier {
  List<Headline> headlinesList = [];
  String currentCategory = 'general';
  int currentPage = 1;
  int categoryIndex = 0;
  bool isLoadingMore = false;

  Future<void> fetchHeadlinesByCategory(
      String category, String country, int index) async {
    categoryIndex = index;
    headlinesList = [];
    currentCategory = category;
    currentPage = 1;

    notifyListeners();

    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&page=1&apiKey=$newsApiKey');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      List<dynamic> articlesJsonData = jsonData['articles'];
      for (var element in articlesJsonData) {
        headlinesList.add(Headline(
            title: element['title'] ?? 'No title',
            author: element['author'] ?? 'Unknown',
            description: element['description'] ?? 'No description',
            url: element['url'] ?? 'null',
            urlToImg: element['urlToImage'] ?? 'null'));
      } //loop through articles json data

      notifyListeners();
    } else {
      headlinesList = [];
      notifyListeners();
    }
  } //fetch headlines by category

  Future<void> fetchMoreHeadlines(
      String category, String country, int page) async {
    List<Headline> nextPageHeadlines = [];
    currentPage = page;
    isLoadingMore = true;
    notifyListeners();

    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&page=$page&apiKey=$newsApiKey');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      List<dynamic> articlesJsonData = jsonData['articles'];
      for (var element in articlesJsonData) {
        nextPageHeadlines.add(Headline(
            title: element['title'] ?? 'No title',
            author: element['author'] ?? 'Unknown',
            description: element['description'] ?? 'No description',
            url: element['url'] ?? 'null',
            urlToImg: element['urlToImage'] ?? 'null'));
      } //loop through articles json data

      headlinesList.addAll(nextPageHeadlines);
      isLoadingMore = false;
      notifyListeners();
    } else {
      isLoadingMore = false;
      notifyListeners();
    }
  } //fetch more headlines

}
