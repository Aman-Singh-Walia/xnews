import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnews/models/search_item_model.dart';
import 'package:xnews/pages/search_item_view_page.dart';

class SearchTile extends StatelessWidget {
  final SearchItem searchItem;
  const SearchTile({Key? key, required this.searchItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12, width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchItemViewPage(openedSearchItem: searchItem)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 115.0,
              width: 115.0,
              child: Image.network(
                searchItem.urlToImg,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const SizedBox(
                    height: 115,
                    width: 115,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 115,
                    width: 115,
                    child: Center(
                      child: Icon(Icons.image),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                  child: Text(
                    searchItem.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                  child: Text(searchItem.description,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14.0)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Text(
                      searchItem.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
