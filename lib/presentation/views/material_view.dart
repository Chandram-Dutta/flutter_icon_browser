import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/icons/material_icons.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MaterialView extends ConsumerWidget {
  const MaterialView({super.key});

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
          itemCount: materialIcons.length,
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
                                title: Text(materialIconsName[index]),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Icon(
                                        materialIcons[index],
                                        size: 200,
                                      ),
                                      Text(
                                        "Code Point: ${materialIcons[index].codePoint}",
                                      ),
                                      Text(
                                        "Font Family: ${materialIcons[index].fontFamily}",
                                      ),
                                      Text(
                                        "Match Text Direction: ${materialIcons[index].matchTextDirection}",
                                      ),
                                      Text(
                                        "IconData: ${materialIcons[index].toString()}",
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
                      materialIcons[index],
                      size: ref.watch(iconSizeProvider),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      materialIconsName[index],
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
