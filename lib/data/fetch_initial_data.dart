import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xnews/data/news_api_key.dart';
import 'package:xnews/models/article_model.dart';
import 'package:xnews/models/headline_model.dart';

Future<String> fetchInitialData(
  List<Article> initialArticlesList,
  List<Headline> initialHeadlinesList,
  String country,
  String language,
) async {
  //fetch initial article___________________________________________________
  var articlesUrl = Uri.parse(
      'https://newsapi.org/v2/everything?q=world&page=1&language=$language&apiKey=$newsApiKey');

  var articleResponse = await http.get(articlesUrl);
  var jsonData = jsonDecode(articleResponse.body);

  if (jsonData['status'] == 'ok') {
    List<dynamic> articlesJsonData = jsonData['articles'];

    for (var element in articlesJsonData) {
      initialArticlesList.add(Article(
          title: element['title'] ?? 'No title',
          author: element['author'] ?? 'Unknown',
          description: element['description'] ?? 'No description',
          url: element['url'] ?? 'null',
          urlToImg: element['urlToImage'] ?? 'null'));
    } //loop through articles json data

  } else {
    initialArticlesList = [];
  }

//fetch initial headlines________________________________________________________
  var headlinesUrl = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=$country&category=general&page=1&apiKey=$newsApiKey');

  var response = await http.get(headlinesUrl);
  var jsonDataH = jsonDecode(response.body);

  if (jsonDataH['status'] == 'ok') {
    List<dynamic> headlinesJsonData = jsonDataH['articles'];
    for (var element in headlinesJsonData) {
      initialHeadlinesList.add(Headline(
          title: element['title'] ?? 'No title',
          author: element['author'] ?? 'Unknown',
          description: element['description'] ?? 'No description',
          url: element['url'] ?? 'null',
          urlToImg: element['urlToImage'] ?? 'null'));
    } //loop through articles json data

  } else {
    initialHeadlinesList = [];
  }
  return 'succeed';
}//fetchInitialData
