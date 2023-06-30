import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/icons/cupertino_icons.dart';
import 'package:flutter_icon_browser/icons/fluentui_icons.dart';
import 'package:flutter_icon_browser/icons/fontawesome_icons.dart';
import 'package:flutter_icon_browser/icons/material_icons.dart';
import 'package:flutter_icon_browser/icons/yaru_icons.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDialog extends ConsumerStatefulWidget {
  const SearchDialog({
    super.key,
  });

  @override
  ConsumerState<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends ConsumerState<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    ref.read(queryProvider.notifier).state = value;
                    // ignore: unused_result
                    ref.refresh(iconSearchProvider);
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, watch, child) {
                    final icons = ref.watch(iconSearchProvider);
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width ~/ 225 == 0
                                ? 1
                                : MediaQuery.of(context).size.width ~/ 225,
                      ),
                      itemCount: icons.$1.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: SelectableText(icons.$2[index]),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Code Point: ${icons.$1[index].codePoint}",
                                      ),
                                      Text(
                                        "Font Family: ${icons.$1[index].fontFamily}",
                                      ),
                                      Text(
                                        "Match Text Direction: ${icons.$1[index].matchTextDirection}",
                                      ),
                                      Text(
                                        "IconData: ${icons.$1[index].toString()}",
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
                          child: Icon(
                            icons.$1[index],
                            size: ref.watch(
                              iconSizeProvider,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final queryProvider = StateProvider.autoDispose<String>((ref) {
  return "-";
});

final iconSearchProvider = Provider.autoDispose((
  ref,
) {
  final fluentIconsData = fluentuiIcons.map((e) => e.iconData).toList();

  final fluentIconsName = fluentuiIcons.map((e) => e.iconName).toList();

  final icons = materialIcons +
      yaruIcons +
      cupertinoIcons +
      fontawesomeIcons +
      fluentIconsData;

  final iconsNames = materialIconsName +
      yaruIconNames +
      cupertinoIconsNames +
      fontawesomeIconsNames +
      fluentIconsName;

  final filteredIcons = iconsNames
      .where((element) =>
          element.toLowerCase().contains(ref.read(queryProvider).toLowerCase()))
      .toList();

  final filteredIconsData = filteredIcons
      .map((e) => icons[iconsNames.indexOf(e)])
      .cast<IconData>()
      .toList();

  return (filteredIconsData, filteredIcons);
});
