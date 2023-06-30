import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      theme: FlexThemeData.light(
        useMaterial3: true,
        scheme: FlexScheme.deepPurple,
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'Expose',
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: true,
        scheme: FlexScheme.deepPurple,
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'Expose',
      ),
      home: const HomePage(),
    );
  }
}
