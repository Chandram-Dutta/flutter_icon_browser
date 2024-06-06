import 'package:flutter/cupertino.dart';
import 'package:flutter_icon_browser/presentation/pages/cupertino_search_page.dart';
import 'package:flutter_icon_browser/presentation/widgets/cupertino_icon_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yaru/yaru.dart';

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.apple),
            label: 'Cupertino',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.google),
            label: 'Material',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.microsoft),
            label: "Fluent",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(YaruIcons.ubuntu_logo_simple),
            label: "Yaru",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.fontAwesome),
            label: "FontAwesome",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text('Flutter Icon Browser'),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const CupertinoSearchPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.search,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (index == 0) {
                      return CupertinoIconGridView(
                        provider: cupertinoIconProvider,
                      );
                    } else if (index == 1) {
                      return CupertinoIconGridView(
                        provider: materialIconProvider,
                      );
                    } else if (index == 2) {
                      return CupertinoIconGridView(
                        provider: fluentIconProvider,
                      );
                    } else if (index == 3) {
                      return CupertinoIconGridView(
                        provider: yaruIconProvider,
                      );
                    } else if (index == 4) {
                      return CupertinoIconGridView(
                        provider: fontawesomeIconProvider,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
