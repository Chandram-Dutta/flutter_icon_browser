import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_browser/icons/fluentui_icons.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FluentUIView extends ConsumerWidget {
  const FluentUIView({super.key});

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
          itemCount: fluentuiIcons.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text: "Icon(FluentIcons.${fluentuiIcons[index].iconName}))",
                  ),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Code Snippet copied to clipboard"),
                    ),
                  );
                }
              },
              child: Card(
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
                                  title: Text(fluentuiIcons[index].iconName),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Icon(
                                          fluentuiIcons[index].iconData,
                                          size: 200,
                                        ),
                                        Text(
                                          "Default Size: ${fluentuiIcons[index].defaultSize}px",
                                        ),
                                        Text(
                                          "Code Point: ${fluentuiIcons[index].iconData.codePoint}",
                                        ),
                                        Text(
                                          "Font Family: ${fluentuiIcons[index].iconData.fontFamily}",
                                        ),
                                        Text(
                                          "Font Package: ${fluentuiIcons[index].iconData.fontPackage}",
                                        ),
                                        Text(
                                          "Match Text Direction: ${fluentuiIcons[index].iconData.matchTextDirection}",
                                        ),
                                        Text(
                                          "IconData: ${fluentuiIcons[index].iconData.toString()}",
                                        ),
                                        const SizedBox(height: 18),
                                        Container(
                                          height: 200,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: SelectableText(
                                              "Icon(FluentIcons.${fluentuiIcons[index].iconName}))",
                                              style: const TextStyle(
                                                fontFamily: "FiraCode",
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
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
                        fluentuiIcons[index].iconData,
                        size: ref.watch(iconSizeProvider),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        fluentuiIcons[index].iconName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
