import 'package:flutter/cupertino.dart';
import 'package:xnews/data/news_api_key.dart';
import 'package:xnews/models/search_item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  List<SearchItem> searchResults = [];
  bool isSearching = false;
  bool isSearchingMore = false;
  int currentPage = 1;

  Future<String> search(String query) async {
    searchResults = [];
    isSearching = true;
    notifyListeners();

    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&page=1&apiKey=$newsApiKey');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      List<dynamic> articlesJsonData = jsonData['articles'];
      for (var element in articlesJsonData) {
        searchResults.add(SearchItem(
            title: element['title'] ?? 'No title',
            author: element['author'] ?? 'Unknown',
            description: element['description'] ?? 'No description',
            url: element['url'] ?? 'null',
            urlToImg: element['urlToImage'] ?? 'null'));
      } //loop through articles json data
      isSearching = false;
      notifyListeners();
    } else {
      searchResults = [];
      isSearching = false;
      notifyListeners();
    }
    return 'success';
  } //search results

  Future<String> searchMore(String query, int page) async {
    isSearchingMore = true;
    currentPage = page;
    notifyListeners();

    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&page=$page&apiKey=$newsApiKey');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      List<dynamic> articlesJsonData = jsonData['articles'];
      for (var element in articlesJsonData) {
        searchResults.add(SearchItem(
            title: element['title'] ?? 'No title',
            author: element['author'] ?? 'Unknown',
            description: element['description'] ?? 'No description',
            url: element['url'] ?? 'null',
            urlToImg: element['urlToImage'] ?? 'null'));
      } //loop through articles json data
      isSearchingMore = false;
      notifyListeners();
    } else {
      searchResults = [];
      isSearchingMore = false;
      notifyListeners();
    }

    return 'success';
  } //search more results
}
