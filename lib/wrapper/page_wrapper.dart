import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xnews/data/fetch_initial_data.dart';

import 'package:xnews/pages/connectivity_page.dart';
import 'package:xnews/pages/home_page.dart';
import 'package:xnews/pages/loading_page.dart';
import 'package:xnews/pages/setup_page.dart';
import 'package:xnews/provider/articles_provider.dart';
import 'package:xnews/provider/headlines_provider.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({Key? key}) : super(key: key);

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool hasInternet = false;
  final languageBox = Hive.box<String>('languageBox');
  final countryBox = Hive.box<String>('countryBox');
  String selectedLanguage = 'en';
  String selectedCountry = 'us';
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((status) {
      setState(() {
        if (status == ConnectivityResult.none) {
          hasInternet = false;
        } else {
          hasInternet = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final articlesProvider =
        Provider.of<ArticlesProvider>(context, listen: false);
    final headlinesProvider =
        Provider.of<HeadlinesProvider>(context, listen: false);
    selectedLanguage = languageBox.get('selectedLanguage') ?? 'en';
    selectedCountry = countryBox.get('selectedCountry') ?? 'us';
    return !hasInternet
        ? const ConnectivityPage()
        : ValueListenableBuilder(
            valueListenable: Hive.box<bool>('setupStateBox').listenable(),
            builder: (context, box, _) {
              final setupStateBox = Hive.box<bool>('setupStateBox');
              final setupState = setupStateBox.get('setupState');
              return setupState == true
                  ? FutureBuilder(
                      future: fetchInitialData(
                        articlesProvider.articlesList,
                        headlinesProvider.headlinesList,
                        selectedCountry,
                        selectedLanguage,
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const LoadingPage();
                          default:
                            return const HomePage();
                        }
                      })
                  : const SetupPage();
            });
  }
}
