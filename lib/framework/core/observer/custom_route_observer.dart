import 'package:flutter/material.dart';
import 'package:mobile_itmu/framework/managers/helper.dart';
import 'package:mobile_itmu/framework/routes/app_pages.dart';

class CustomRouteObserver extends NavigatorObserver {
  List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    List<String> historyTemp = [];
    for (var element
        in routerDelegate.routerDelegate.currentConfiguration.matches) {
      historyTemp.addAll(element.matchedLocation.split('/'));
    }
    historyTemp.removeWhere(
      (element) => element.isEmpty,
    );
    _history = historyTemp.toSet().toList();
    // _history.add(route.settings.name ?? route.settings.name ?? route.settings.name.toString());
    printWarning('Page Pushed: ${route.settings.name}');
    printWarning('History: $_history');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    List<String> historyTemp = [];
    for (var element
        in routerDelegate.routerDelegate.currentConfiguration.matches) {
      historyTemp.addAll(element.matchedLocation.split('/'));
    }
    historyTemp.removeWhere(
      (element) => element.isEmpty,
    );
    _history = historyTemp.toSet().toList();
    // _history.remove(route.settings.name ?? route.settings.name.toString());
    printWarning('Page Popped: ${route.settings.name}');
    printWarning('History: $_history');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    List<String> historyTemp = [];
    for (var element
        in routerDelegate.routerDelegate.currentConfiguration.matches) {
      historyTemp.addAll(element.matchedLocation.split('/'));
    }
    historyTemp.removeWhere(
      (element) => element.isEmpty,
    );
    _history = historyTemp.toSet().toList();
    // _history.remove(newRoute?.settings.name ?? newRoute?.settings.name.toString());
    printWarning('Page Replaced From : ${oldRoute?.settings.name}');
    printWarning('To : ${newRoute?.settings.name}');
    printWarning('History: $_history');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
