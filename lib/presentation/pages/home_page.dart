import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/presentation/views/cupertino_view.dart';
import 'package:flutter_icon_browser/presentation/views/fluentui_view.dart';
import 'package:flutter_icon_browser/presentation/views/fontawesome_view.dart';
import 'package:flutter_icon_browser/presentation/views/material_view.dart';
import 'package:flutter_icon_browser/presentation/views/yaru_view.dart';
import 'package:flutter_icon_browser/presentation/widgets/search_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru_icons/yaru_icons.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Icon Browser'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SearchDialog(),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    "assets/logo.png",
                    width: 128,
                    fit: BoxFit.fitWidth,
                  ),
                  applicationName: "Flutter Icon Browser",
                  applicationVersion: "1.0.2",
                  applicationLegalese:
                      "Chandram Dutta © 2023 - BSD-3-Clause License",
                );
              },
              icon: const Icon(
                Icons.info_outline_rounded,
              ),
            ),
            IconButton(
              onPressed: () async {
                launchUrl(
                  Uri.parse(
                    "https://github.com/Chandram-Dutta/flutter_icon_browser",
                  ),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.github,
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            constraints.maxWidth > 600
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: NavigationRail(
                            extended: MediaQuery.of(context).size.width > 900,
                            destinations: const [
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.google),
                                label: Text("MaterialIcons"),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.apple),
                                label: Text("CupertinoIcons"),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.microsoft),
                                label: Text("FluentIcons"),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(YaruIcons.ubuntu_logo_simple),
                                label: Text("YaruIcons"),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.fontAwesome),
                                label: Text("FontAwesomeIcons"),
                              ),
                            ],
                            selectedIndex: _selectedIndex,
                            onDestinationSelected: (value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                          ),
                        ),
                        RotatedBox(
                          quarterTurns:
                              MediaQuery.of(context).size.width > 900 ? 0 : -1,
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Icon Size",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  Slider(
                                    thumbColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    activeColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    value: ref.watch(iconSizeProvider),
                                    onChanged: (value) {
                                      ref
                                          .read(iconSizeProvider.notifier)
                                          .state = value.floorToDouble();
                                    },
                                    min: 18,
                                    max: 128,
                                    divisions: 12,
                                    autofocus: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (_selectedIndex == 0) {
                    return const MaterialView();
                  } else if (_selectedIndex == 1) {
                    return const CupertinoView();
                  } else if (_selectedIndex == 2) {
                    return const FluentUIView();
                  } else if (_selectedIndex == 3) {
                    return const YaruView();
                  } else if (_selectedIndex == 4) {
                    return const FontAwesomeView();
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      );
    });
  }
}

final iconSizeProvider = StateProvider<double>((ref) {
  return 48.0;
});
