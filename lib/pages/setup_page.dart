import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xnews/data/available_countries_data.dart';
import 'package:xnews/data/available_languages_data.dart';
import 'package:xnews/models/country_model.dart';
import 'package:xnews/models/language_model.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  Country selectedCountry = Country(name: 'United States', code: 'us');
  Language selectedLanguage = Language(language: 'English', code: 'en');
  @override
  Widget build(BuildContext context) {
    final setupStateBox = Hive.box<bool>('setupStateBox');
    final languageBox = Hive.box<String>('languageBox');
    final countryBox = Hive.box<String>('countryBox');
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Welcome to X-News',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    ],
                  ),
                ),

                //region selector
                const Text(
                  'Region',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCountry.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0))),
                              context: context,
                              builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    child: Column(
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
                                                        Navigator.pop(context);

                                                        setState(() {
                                                          selectedCountry = e;
                                                        });
                                                      },
                                                      title: Text(
                                                        e.name,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: Icon(
                                                          selectedCountry == e
                                                              ? CupertinoIcons
                                                                  .location_fill
                                                              : CupertinoIcons
                                                                  .location),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        icon: const Icon(
                          CupertinoIcons.location_fill,
                          color: Colors.white,
                        ))
                  ],
                ),

                //language selector
                const Text(
                  'Language',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLanguage.language,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0))),
                              context: context,
                              builder: (context) => SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    child: Column(
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
                                          'Select language',
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
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          selectedLanguage = e;
                                                        });
                                                      },
                                                      title: Text(
                                                        e.language,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: Icon(
                                                          selectedLanguage == e
                                                              ? Icons.language
                                                              : Icons
                                                                  .circle_outlined),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        icon: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: IconButton(
                        onPressed: () {
                          languageBox.put(
                              'selectedLanguage', selectedLanguage.code);
                          countryBox.put(
                              'selectedCountry', selectedCountry.code);
                          setupStateBox.put('setupState', true);
                        },
                        icon: const Icon(
                          CupertinoIcons.forward,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
