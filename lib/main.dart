import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Icon Browser',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'Expose',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'Expose',
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}
