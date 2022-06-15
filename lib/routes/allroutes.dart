import 'package:flutter/material.dart';
import 'package:mario/view/main/view/mainPage.dart';

class Allroutes {
  static final Allroutes _instance = Allroutes.init();
  static Allroutes get instance => _instance;
  Allroutes.init();

  Route? ongenerateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return pageReturner(const MainPage());
    }
  }

  pageReturner(Widget page) => MaterialPageRoute(builder: (_) => page);
}
