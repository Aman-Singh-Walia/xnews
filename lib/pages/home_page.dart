import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnews/pages/search_page.dart';
import 'package:xnews/pages/settings_page.dart';
import 'package:xnews/tabs/articles_tab.dart';
import 'package:xnews/tabs/headlines_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;
  List<Widget> tabs = const [ArticlesTab(), HeadlinesTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X-News'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: tabs[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          onTap: (v) {
            setState(() {
              selectedTabIndex = v;
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: 'Articles', icon: Icon(Icons.newspaper)),
            BottomNavigationBarItem(
                label: 'Highlights', icon: Icon(Icons.highlight)),
          ]),
    );
  }
}
