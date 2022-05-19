import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnews/provider/articles_provider.dart';
import 'package:xnews/widgets/article_tile.dart';
import 'package:xnews/widgets/bottom_button_listview.dart';
import 'package:xnews/widgets/no_items.dart';

class ArticlesTab extends StatefulWidget {
  const ArticlesTab({Key? key}) : super(key: key);

  @override
  State<ArticlesTab> createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  @override
  Widget build(BuildContext context) {
    final articlesProvider = Provider.of<ArticlesProvider>(context);
    return articlesProvider.articlesList.isEmpty
        ? const NoItem(message: 'Articles not found')
        : BottomButtonListview(
            children: articlesProvider.articlesList
                .map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: ArticleTile(article: e),
                    ))
                .toList(),
            onButtonPressed: () {
              articlesProvider
                  .fetchMoreArticles(articlesProvider.currentPage + 1);
            },
            loadingMore: articlesProvider.isloadingMoreArticles,
            disableMoreButton: false,
          );
  }
}
