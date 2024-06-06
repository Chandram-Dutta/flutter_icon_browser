import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/presentation/widgets/icon_grid_view.dart';
import 'package:flutter_icon_browser/presentation/widgets/search_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';

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
            constraints.maxWidth > 600
                ? IconButton(
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Image.asset(
                          "assets/logo.png",
                          width: 128,
                          fit: BoxFit.fitWidth,
                        ),
                        applicationName: "Flutter Icon Browser",
                        applicationVersion: "2.0.0",
                        applicationLegalese:
                            "Chandram Dutta © 2023 - BSD-3-Clause License",
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline_rounded,
                    ),
                  )
                : const SizedBox(),
            constraints.maxWidth > 600
                ? IconButton(
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
                  )
                : const SizedBox(),
          ],
        ),
        drawer: constraints.maxWidth < 600
            ? Drawer(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DrawerHeader(
                        child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/logo.png",
                              width: 64,
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text("Flutter Icon Browser")
                          ],
                        ),
                      ),
                    )),
                    ListTile(
                      title: const Text("App Info"),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationIcon: Image.asset(
                            "assets/logo.png",
                            width: 64,
                            fit: BoxFit.fitWidth,
                          ),
                          applicationName: "Flutter Icon Browser",
                          applicationVersion: "2.0.0",
                          applicationLegalese:
                              "Chandram Dutta © 2023 - BSD-3-Clause License",
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Github"),
                      onTap: () async {
                        launchUrl(
                          Uri.parse(
                            "https://github.com/Chandram-Dutta/flutter_icon_browser",
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            : null,
        bottomNavigationBar: constraints.maxWidth < 600
            ? NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                onDestinationSelected: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                selectedIndex: _selectedIndex,
                destinations: const [
                  NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: "MaterialIcons",
                  ),
                  NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.apple),
                    label: "CupertinoIcons",
                  ),
                  NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.microsoft),
                    label: "FluentIcons",
                  ),
                  NavigationDestination(
                    icon: FaIcon(YaruIcons.ubuntu_logo_simple),
                    label: "YaruIcons",
                  ),
                  NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.fontAwesome),
                    label: "FontAwesomeIcons",
                  ),
                ],
              )
            : null,
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
                    return IconGridView(
                      provider: materialIconProvider,
                    );
                  } else if (_selectedIndex == 1) {
                    return IconGridView(
                      provider: cupertinoIconProvider,
                    );
                  } else if (_selectedIndex == 2) {
                    return IconGridView(
                      provider: fluentIconProvider,
                    );
                  } else if (_selectedIndex == 3) {
                    return IconGridView(
                      provider: yaruIconProvider,
                    );
                  } else if (_selectedIndex == 4) {
                    return IconGridView(
                      provider: fontawesomeIconProvider,
                    );
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
