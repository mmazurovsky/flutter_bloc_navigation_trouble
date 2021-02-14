import 'package:flutter/material.dart';

enum TabItem { red, green, blue }

extension TabItemExtension on TabItem {
  static const Map<TabItem, String> tabNameMap = {
    TabItem.red: 'red',
    TabItem.green: 'green',
    TabItem.blue: 'blue',
  };

  static const Map<TabItem, MaterialColor> activeTabColorMap = {
    TabItem.red: Colors.red,
    TabItem.green: Colors.green,
    TabItem.blue: Colors.blue,
  };

  String get tabName => tabNameMap[this];
  Color get activeTabColor => activeTabColorMap[this];
}
