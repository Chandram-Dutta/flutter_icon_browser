import 'package:flutter/cupertino.dart';
import 'package:flutter_icon_browser/model/icon_model.dart';

class CupertinoIconsDetailPage extends StatelessWidget {
  const CupertinoIconsDetailPage({
    super.key,
    required this.icon,
  });

  final IconModel icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: "Flutter Icon Browser",
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: (icon.iconName),
                  child: Icon(
                    icon.icon,
                    size: 128,
                  ),
                ),
                const SizedBox(height: 16),
                icon.iconLibrary == null
                    ? const SizedBox()
                    : Text("Icon Library: ${icon.iconLibrary}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
