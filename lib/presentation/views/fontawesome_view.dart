import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/icons/fontawesome_icons.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FontAwesomeView extends ConsumerWidget {
  const FontAwesomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth ~/ 225 == 0
                ? 1
                : constraints.maxWidth ~/ 225,
          ),
          itemCount: fontawesomeIcons.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(fontawesomeIconsNames[index]),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        fontawesomeIcons[index],
                                        size: 200,
                                      ),
                                      Text(
                                        "Code Point: ${fontawesomeIcons[index].codePoint}",
                                      ),
                                      Text(
                                        "Font Family: ${fontawesomeIcons[index].fontFamily}",
                                      ),
                                      Text(
                                        "Font Package: ${fontawesomeIcons[index].fontPackage}",
                                      ),
                                      Text(
                                        "Match Text Direction: ${fontawesomeIcons[index].matchTextDirection}",
                                      ),
                                      Text(
                                        "IconData: ${fontawesomeIcons[index].toString()}",
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline_rounded),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FaIcon(
                      fontawesomeIcons[index],
                      size: ref.watch(iconSizeProvider),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      fontawesomeIconsNames[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
