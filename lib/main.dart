import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xnews/provider/articles_provider.dart';
import 'package:xnews/provider/headlines_provider.dart';
import 'package:xnews/provider/search_provider.dart';
import 'package:xnews/wrapper/page_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<bool>('setupStateBox');
  await Hive.openBox<List<String>>('categoriesBox');
  await Hive.openBox<String>('themeBox');
  await Hive.openBox<String>('languageBox');
  await Hive.openBox<String>('countryBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<String>('themeBox').listenable(),
        builder: (context, box, _) {
          final themeBox = Hive.box<String>('themeBox');
          final selectedTheme = themeBox.get('selectedTheme');

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: ((context) => SearchProvider())),
              ChangeNotifierProvider(create: ((context) => ArticlesProvider())),
              ChangeNotifierProvider(create: ((context) => HeadlinesProvider()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: selectedTheme == 'light'
                  ? ThemeMode.light
                  : selectedTheme == 'dark'
                      ? ThemeMode.dark
                      : ThemeMode.system,
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  appBarTheme: const AppBarTheme(
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                      ))),
              darkTheme: ThemeData(
                  colorScheme: const ColorScheme.dark(
                      secondary: Colors.purple, primary: Colors.white),
                  primarySwatch: Colors.purple,
                  appBarTheme: const AppBarTheme(
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                      )),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey)),
              home: const PageWrapper(),
            ),
          );
        });
  }
}
