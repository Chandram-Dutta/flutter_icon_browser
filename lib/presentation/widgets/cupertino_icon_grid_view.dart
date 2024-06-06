import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_browser/icons/cupertino_icons.dart';
import 'package:flutter_icon_browser/icons/fluentui_icons.dart';
import 'package:flutter_icon_browser/icons/fontawesome_icons.dart';
import 'package:flutter_icon_browser/icons/material_icons.dart';
import 'package:flutter_icon_browser/icons/yaru_icons.dart';
import 'package:flutter_icon_browser/model/icon_model.dart';
import 'package:flutter_icon_browser/presentation/pages/cupertino_icons_detail_page.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CupertinoIconGridView extends ConsumerWidget {
  const CupertinoIconGridView({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (data) => SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                // onTap: () => showIconDetailsDialog(context, data[index]),
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => CupertinoIconsDetailPage(
                        icon: data[index],
                      ),
                      title: data[index].iconName,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Hero(
                            tag: (data[index].iconName),
                            child: Icon(
                              data[index].icon,
                              size: ref.watch(iconSizeProvider),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            data[index].iconName,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          error: (error, stackTrace) => SliverFillRemaining(
            child: Center(
              child: Text(error.toString()),
            ),
          ),
          loading: () => const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
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
