import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:xnews/provider/headlines_provider.dart';
import 'package:xnews/widgets/bottom_button_listview.dart';
import 'package:xnews/widgets/category_bar.dart';
import 'package:xnews/widgets/headline_tile.dart';

class HeadlinesTab extends StatefulWidget {
  const HeadlinesTab({Key? key}) : super(key: key);

  @override
  State<HeadlinesTab> createState() => _HeadlinesTabState();
}

class _HeadlinesTabState extends State<HeadlinesTab> {
  List<String> defaultAvailableCategories = [
    'General',
  ];

  final countryBox = Hive.box<String>('countryBox');

  @override
  Widget build(BuildContext context) {
    final headlinesProvider =
        Provider.of<HeadlinesProvider>(context, listen: true);
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable:
                Hive.box<List<String>>('categoriesBox').listenable(),
            builder: (context, box, _) {
              final categoriesBox = Hive.box<List<String>>('categoriesBox');
              List<String> selectedCategories =
                  categoriesBox.get('selectedCategories') ?? [];
              defaultAvailableCategories.addAll(selectedCategories);
              return CategoryBar(
                  categories: defaultAvailableCategories,
                  selectedIndex: headlinesProvider.categoryIndex,
                  onSelected: (v) {
                    String selectedCountry =
                        countryBox.get('selectedCountry') ?? 'us';
                    headlinesProvider.fetchHeadlinesByCategory(
                        defaultAvailableCategories[v], selectedCountry, v);
                  });
            }),
        Expanded(
            child: BottomButtonListview(
          children: headlinesProvider.headlinesList
              .map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    child: HeadlineTile(headline: e),
                  ))
              .toList(),
          loadingMore: headlinesProvider.isLoadingMore,
          onButtonPressed: () {
            String selectedCountry = countryBox.get('selectedCountry') ?? 'us';
            headlinesProvider.fetchMoreHeadlines(
                headlinesProvider.currentCategory,
                selectedCountry,
                headlinesProvider.currentPage + 1);
          },
        ))
      ],
    );
  }
}
