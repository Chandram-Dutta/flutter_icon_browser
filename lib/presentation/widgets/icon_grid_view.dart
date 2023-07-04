import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_browser/icons/cupertino_icons.dart';
import 'package:flutter_icon_browser/icons/fluentui_icons.dart';
import 'package:flutter_icon_browser/icons/fontawesome_icons.dart';
import 'package:flutter_icon_browser/icons/material_icons.dart';
import 'package:flutter_icon_browser/icons/yaru_icons.dart';
import 'package:flutter_icon_browser/model/icon_model.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconGridView extends ConsumerWidget {
  const IconGridView({
    required this.provider,
    super.key,
  });

  final AutoDisposeFutureProvider<List<IconModel>> provider;

  Future copyToClipboard(BuildContext context, IconModel icon) async {
    await Clipboard.setData(
      ClipboardData(
        text: icon.toCodeSnippet(),
      ),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code Snippet copied to clipboard"),
        ),
      );
    }
  }

  showIconDetailsDialog(BuildContext context, IconModel icon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(icon.iconName),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                icon.icon,
                size: 200,
              ),
              Text(
                "Code Point: ${icon.icon.codePoint}",
              ),
              Text(
                "Font Family: ${icon.icon.fontFamily}",
              ),
              Text(
                "Match Text Direction: ${icon.icon.matchTextDirection}",
              ),
              Text(
                "IconData: ${icon.icon.toString()}",
              ),
              const SizedBox(height: 18),
              Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SelectableText(
                    icon.toCodeSnippet(),
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (data) => LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth ~/ 225 <= 2
                    ? 3
                    : constraints.maxWidth ~/ 225,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => constraints.maxWidth ~/ 225 <= 2
                      ? showIconDetailsDialog(context, data[index])
                      : copyToClipboard(context, data[index]),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          constraints.maxWidth ~/ 225 <= 2
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => showIconDetailsDialog(
                                          context, data[index]),
                                      icon: const Icon(
                                          Icons.info_outline_rounded),
                                    ),
                                  ],
                                ),
                          const Spacer(),
                          Icon(
                            data[index].icon,
                            size: ref.watch(iconSizeProvider),
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            data[index].iconName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(
                            flex: constraints.maxWidth ~/ 225 <= 2 ? 1 : 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}

final materialIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  List<IconModel> icons = [];
  for (var i = 0; i < materialIcons.length; i++) {
    final icon = IconModel(
      icon: materialIcons[i],
      iconName: materialIconsName[i],
      iconLibrary: "Icons",
    );
    icons.add(icon);
  }
  return icons;
});

final cupertinoIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  List<IconModel> icons = [];
  for (var i = 0; i < cupertinoIcons.length; i++) {
    final icon = IconModel(
      icon: cupertinoIcons[i],
      iconName: cupertinoIconsNames[i],
      iconLibrary: "CupertinoIcons",
    );
    icons.add(icon);
  }
  return icons;
});

final fluentIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  List<IconModel> icons = [];
  for (var i = 0; i < fluentuiIcons.length; i++) {
    final icon = IconModel(
      icon: fluentuiIcons[i].iconData,
      iconName: fluentuiIcons[i].iconName,
      iconLibrary: "FluentIcons",
    );
    icons.add(icon);
  }
  return icons;
});

final yaruIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  List<IconModel> icons = [];
  for (var i = 0; i < yaruIcons.length; i++) {
    final icon = IconModel(
      icon: yaruIcons[i],
      iconName: yaruIconNames[i],
      iconLibrary: "YaruIcons",
    );
    icons.add(icon);
  }
  return icons;
});

final fontawesomeIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  List<IconModel> icons = [];
  for (var i = 0; i < fontawesomeIcons.length; i++) {
    final icon = IconModel(
      icon: fontawesomeIcons[i],
      iconName: fontawesomeIconsNames[i],
      iconLibrary: "FontAwesomeIcons",
    );
    icons.add(icon);
  }
  return icons;
});
