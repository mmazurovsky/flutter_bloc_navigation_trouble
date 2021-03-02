import 'package:flutter/material.dart';
import 'package:flutter_bug_in_bloc_project/color_details_page.dart';
import 'package:flutter_bug_in_bloc_project/tab_item.dart';

import 'color_list_page.dart';

// 1
class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

// 2
class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  // 3
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: tabItem.activeTabColor,
            title: tabItem.tabName,
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: tabItem.activeTabColor,
            title: tabItem.tabName,
            materialIndex: materialIndex,
          ),
    };
  }

  // 4
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) =>
              _routeBuilders(context)[routeSettings.name](context),
        );
      },
    );
  }

  // 5
  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }
}
