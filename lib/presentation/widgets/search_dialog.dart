import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/icons/cupertino_icons.dart';
import 'package:flutter_icon_browser/icons/fluentui_icons.dart';
import 'package:flutter_icon_browser/icons/fontawesome_icons.dart';
import 'package:flutter_icon_browser/icons/material_icons.dart';
import 'package:flutter_icon_browser/icons/yaru_icons.dart';
import 'package:flutter_icon_browser/model/icon_model.dart';
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
                size: 64,
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
                    ref.refresh(allIconProvider);
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
                child: ref.watch(allIconProvider).when(
                      data: (data) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 200 <= 2
                                  ? 3
                                  : MediaQuery.of(context).size.width ~/ 200,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () =>
                              showIconDetailsDialog(context, data[index]),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              data[index].icon,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                      error: (err, stack) => Center(
                        child: Text(
                          err.toString(),
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
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
  return "";
});

final allIconProvider =
    FutureProvider.autoDispose<List<IconModel>>((ref) async {
  final fluentIconsData = fluentuiIcons.map((e) => e.iconData).toList();

  final fluentIconsName = fluentuiIcons.map((e) => e.iconName).toList();

  var icons = materialIcons +
      yaruIcons +
      cupertinoIcons +
      fontawesomeIcons +
      fluentIconsData;

  var iconsNames = materialIconsName +
      yaruIconNames +
      cupertinoIconsNames +
      fontawesomeIconsNames +
      fluentIconsName;

  List<IconModel> allIcons = [];

  for (var i = 0; i < icons.length; i++) {
    final icon = IconModel(
      icon: icons[i],
      iconName: iconsNames[i],
      iconLibrary: null,
    );
    if (icon.toString().contains(ref.watch(queryProvider).toLowerCase())) {
      allIcons.add(icon);
    }
  }
  return allIcons;
});
