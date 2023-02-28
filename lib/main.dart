import 'package:busca_de_desaparecidos/app_theme.dart';
import 'package:busca_de_desaparecidos/ui/pages/pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca de Desaparecidos',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeClass.darkTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    );
  }
}
