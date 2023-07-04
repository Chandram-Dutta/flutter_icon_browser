import 'package:flutter/material.dart';

class IconModel {
  final IconData icon;
  final String iconName;
  final String? iconLibrary;

  IconModel({
    required this.icon,
    required this.iconName,
    this.iconLibrary,
  });

  String toCodeSnippet() {
    return iconLibrary != null
        ? iconLibrary == "FontAwesomeIcons"
            ? "FaIcon($iconLibrary.$iconName)"
            : "Icon($iconLibrary.$iconName)"
        : "";
  }

  @override
  String toString() => iconName;
}
