import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_browser/presentation/pages/cupertino_icons_detail_page.dart';
import 'package:flutter_icon_browser/presentation/pages/home_page.dart';
import 'package:flutter_icon_browser/presentation/widgets/search_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CupertinoSearchPage extends ConsumerStatefulWidget {
  const CupertinoSearchPage({super.key});

  @override
  ConsumerState<CupertinoSearchPage> createState() =>
      _CupertinoSearchPageState();
}

class _CupertinoSearchPageState extends ConsumerState<CupertinoSearchPage> {
  final TextEditingController searchField = TextEditingController();

  @override
  dispose() {
    super.dispose();
    searchField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: CupertinoSearchTextField(
            controller: searchField,
            onChanged: (value) {
              setState(() {
                ref.read(queryProvider.notifier).state = value;
                // ignore: unused_result
                ref.refresh(allIconProvider);
              });
            },
          ),
        ),
        child: ref.watch(allIconProvider).when(
              data: (data) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
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
                              Icon(
                                data[index].icon,
                                size: ref.watch(iconSizeProvider),
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
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CupertinoActivityIndicator(),
              ),
            ));
  }
}
