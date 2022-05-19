import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnews/models/article_model.dart';
import 'package:xnews/pages/article_view_page.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black12, width: 1.5)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArticleViewPage(openedArticle: article)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              article.urlToImg,
              fit: BoxFit.fill,
              height: 150,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Center(
                    child: Icon(Icons.image),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: Text(article.title,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.description,
                  maxLines: 4,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(article.author)],
              ),
            )
          ],
        ),
      ),
    );
  }
}
