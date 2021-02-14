import 'package:flutter/material.dart';
import 'package:flutter_bug_in_bloc_project/bottom_navigation.dart';
import 'package:flutter_bug_in_bloc_project/tab_item.dart';
import 'package:flutter_bug_in_bloc_project/tab_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/colors_bloc.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  final navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorsBloc(),
      child: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab].currentState.maybePop(),
        child: Scaffold(
          body: Stack(
            children: [
              _buildOffstageNavigator(TabItem.red),
              _buildOffstageNavigator(TabItem.green),
              _buildOffstageNavigator(TabItem.blue),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
