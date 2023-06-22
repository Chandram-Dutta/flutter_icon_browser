import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/icons/yaru_icons.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YaruView extends ConsumerWidget {
  const YaruView({super.key});

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
          itemCount: yaruIconNames.length,
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
                                title: Text(yaruIconNames[index]),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Icon(
                                        yaruIcons[index],
                                        size: 200,
                                      ),
                                      Text(
                                        "Code Point: ${yaruIcons[index].codePoint}",
                                      ),
                                      Text(
                                        "Font Family: ${yaruIcons[index].fontFamily}",
                                      ),
                                      Text(
                                        "Font Package: ${yaruIcons[index].fontPackage}",
                                      ),
                                      Text(
                                        "Match Text Direction: ${yaruIcons[index].matchTextDirection}",
                                      ),
                                      Text(
                                        "IconData: ${yaruIcons[index].toString()}",
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
                    Icon(
                      yaruIcons[index],
                      size: ref.watch(iconSizeProvider),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      yaruIconNames[index],
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
