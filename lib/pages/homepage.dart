import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/pages/chat/chat_page.dart';
import 'package:localchat/pages/settings/settings_page.dart';
import 'package:localchat/utils.dart' as utils;

enum HomeTab {
  // network(Icons.wifi),
  chat(Icons.send),

  settings(Icons.settings);

  const HomeTab(this.icon);

  final IconData icon;

  String get label {
    switch (this) {
      // case HomeTab.network:
      //   return t.networkTab.title;
      case HomeTab.chat:
        return t.chatTab.title;
      case HomeTab.settings:
        return t.settingsTab.title;
    }
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  final HomeTab initialTab = HomeTab.chat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends ConsumerState<HomePage> {
  late PageController _pageController;
  late HomeTab _currentTab;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialTab.index);
    _currentTab = widget.initialTab;
    utils.setMainRef(ref);
  }

  void _goToPage(int index) {
    final tab = HomeTab.values[index];
    setState(() {
      _currentTab = tab;
      _pageController.jumpToPage(_currentTab.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Translations.of(context); // rebuild on locale change
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            selectedIndex: _currentTab.index,
            onDestinationSelected: _goToPage,
            // extended: sizingInformation.isDesktop,
            // backgroundColor: Theme.of(context).cardColorWithElevation,
            leading: const Column(
              children: [
                SizedBox(height: 20),
              ],
            ),
            destinations: HomeTab.values.map((tab) {
              return NavigationRailDestination(
                icon: Icon(tab.icon),
                label: Text(tab.label),
              );
            }).toList(),
          ),
          Expanded(
            child: SafeArea(
              left: false,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      // NetworkPage(),
                      ChatPage(),
                      SettingsPage(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
