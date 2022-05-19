import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnews/provider/search_provider.dart';
import 'package:xnews/widgets/bottom_button_listview.dart';
import 'package:xnews/widgets/no_items.dart';
import 'package:xnews/widgets/search_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.clear),
        ),
        title: TextField(
          controller: searchFieldController,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white30),
              border: InputBorder.none,
              hintText: 'Search'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                searchProvider.search(searchFieldController.text);
              },
              icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: searchProvider.searchResults.isEmpty
          ? const NoItem(message: 'no results found')
          : searchProvider.isSearching && searchProvider.searchResults.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : BottomButtonListview(
                  children: searchProvider.searchResults
                      .map((e) => SearchTile(searchItem: e))
                      .toList(),
                  loadingMore: searchProvider.isSearchingMore,
                  onButtonPressed: () {
                    searchProvider.searchMore(searchFieldController.text,
                        searchProvider.currentPage + 1);
                  },
                ),
    );
  }
}
