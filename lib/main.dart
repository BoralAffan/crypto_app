import 'package:crypto_app/constants/themes.dart';
import 'package:crypto_app/models/localStorage.dart';
import 'package:crypto_app/pages/HomePage.dart';
import 'package:crypto_app/providers/marketProviders.dart';
import 'package:crypto_app/providers/themeProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? 'light';
  runApp(MyApp(theme: currentTheme,));
}

class MyApp extends StatelessWidget {
  final String theme;
    MyApp({required this.theme});
  
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeModeProvider>(
            create: (context) => ThemeModeProvider(theme)),
      ],
      child:
          Consumer<ThemeModeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cryptofy',
          theme: LightTheme,
          themeMode: themeProvider.themeMode,
          darkTheme: DarkTheme,
          home: HomePage(),
        );
      }),
    );
  }
}
