import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xnews/data/available_categories.dart';
import 'package:xnews/data/available_countries_data.dart';
import 'package:xnews/data/available_languages_data.dart';
import 'package:xnews/models/country_model.dart';
import 'package:xnews/models/language_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final languageBox = Hive.box<String>('languageBox');
  final countryBox = Hive.box<String>('countryBox');
  final themeBox = Hive.box<String>('themeBox');
  final categoriesBox = Hive.box<List<String>>('categoriesBox');
  String selectedTheme = 'system';
  String selectedLanguage = 'en';
  String selectedCountry = 'us';
  late Country selectedCountryData;
  late Language selectedLanguageData;
  List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    selectedLanguage = languageBox.get('selectedLanguage') ?? 'en';
    selectedCountry = countryBox.get('selectedCountry') ?? 'us';
    selectedCountryData =
        availableCountries.firstWhere((e) => e.code == selectedCountry);
    selectedLanguageData =
        availableLanguages.firstWhere((e) => e.code == selectedLanguage);

    selectedCategories = categoriesBox.get('selectedCategories') ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.back)),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Theme',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Icon(
                        selectedTheme == 'dark'
                            ? CupertinoIcons.moon_fill
                            : selectedTheme == 'light'
                                ? CupertinoIcons.brightness_solid
                                : CupertinoIcons.circle_lefthalf_fill,
                        size: 35.0,
                        color: Colors.purple,
                      )
                    ],
                  ),
                ),
                RadioListTile<String>(
                    activeColor: Colors.purple,
                    title: const Text(
                      'Dark',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'dark',
                    groupValue: selectedTheme,
                    onChanged: (v) {
                      selectedTheme = v!;
                      final b = Hive.box<String>('themeBox');
                      b.put('selectedTheme', 'dark');
                      setState(() {});
                    }),
                RadioListTile<String>(
                    activeColor: Colors.purple,
                    title: const Text(
                      'Light',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'light',
                    groupValue: selectedTheme,
                    onChanged: (v) {
                      selectedTheme = v!;

                      final b = Hive.box<String>('themeBox');
                      b.put('selectedTheme', 'light');
                      setState(() {});
                    }),
                RadioListTile<String>(
                    activeColor: Colors.purple,
                    title: const Text(
                      'System',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: 'system',
                    groupValue: selectedTheme,
                    onChanged: (v) {
                      selectedTheme = v!;

                      final b = Hive.box<String>('themeBox');
                      b.put('selectedTheme', 'system');
                      setState(() {});
                    })
              ],
            ),
          ),

          //region selector
          Container(
              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black12),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    child: Text(
                      'Region',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                        child: Text(
                          selectedCountryData.name,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0))),
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 10.0, 0.0, 10.0),
                                          height: 3.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                        ),
                                        const Text(
                                          'Select Region',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: availableCountries
                                                .map((e) => ListTile(
                                                      onTap: () {
                                                        countryBox.put(
                                                            'selectedCountry',
                                                            e.code);
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      title: Text(
                                                        e.name,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: e.code ==
                                                              selectedCountry
                                                          ? const Icon(
                                                              CupertinoIcons
                                                                  .location_fill,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(
                                                              CupertinoIcons
                                                                  .location),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            CupertinoIcons.location_fill,
                            color: Colors.purple,
                          ))
                    ],
                  ),
                ],
              )),

          //language selector

          Container(
              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black12),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    child: Text(
                      'Language',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                        child: Text(
                          selectedLanguageData.language,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0))),
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 10.0, 0.0, 10.0),
                                          height: 3.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                        ),
                                        const Text(
                                          'Select Language',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            children: availableLanguages
                                                .map((e) => ListTile(
                                                      onTap: () {
                                                        languageBox.put(
                                                            'selectedLanguage',
                                                            e.code);
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      title: Text(
                                                        e.language,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: e.code ==
                                                              selectedLanguage
                                                          ? const Icon(
                                                              CupertinoIcons
                                                                  .checkmark_alt,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(Icons
                                                              .language_outlined),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon:
                              const Icon(Icons.language, color: Colors.purple))
                    ],
                  ),
                ],
              )),
          //category selector

          Container(
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black12),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    'Categories',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: availableCategories
                      .map((e) => ListTile(
                            title: Text(
                              e,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  if (selectedCategories.contains(e)) {
                                    selectedCategories.remove(e);
                                  } else {
                                    selectedCategories.add(e);
                                  }

                                  categoriesBox.put(
                                      'selectedCategories', selectedCategories);
                                  setState(() {});
                                },
                                icon: selectedCategories.contains(e)
                                    ? const Icon(
                                        CupertinoIcons.minus,
                                        color: CupertinoColors.destructiveRed,
                                      )
                                    : const Icon(
                                        CupertinoIcons.add,
                                        color: CupertinoColors.activeGreen,
                                      )),
                          ))
                      .toList(),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
