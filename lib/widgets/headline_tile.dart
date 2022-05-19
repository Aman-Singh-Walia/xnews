import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnews/models/headline_model.dart';
import 'package:xnews/pages/headline_view_page.dart';

class HeadlineTile extends StatelessWidget {
  final Headline headline;
  const HeadlineTile({Key? key, required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeadlineViewPage(openedHeadline: headline)));
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Image.network(
                    headline.urlToImg,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Icon(Icons.image),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Text(
                      headline.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                      maxLines: 3,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(headline.description,
                  maxLines: 4,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.0)),
            )
          ],
        ),
      ),
    );
  }
}
