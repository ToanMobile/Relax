import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/ui/screen/capture/capture_page.dart';
import 'package:relax/ui/screen/code/check_code_page.dart';
import 'package:relax/ui/screen/home/home_page.dart';
import 'package:relax/ui/screen/login/login_page.dart';
import 'package:relax/ui/screen/map/map_page.dart';
import 'package:relax/ui/widget/page_route_anim.dart';

class RouteName {
  static const String home = '/';
  static const String login = 'login';
  static const String register = 'register';
  static const String map = 'map';
  static const String code = 'code';
  static const String capture = 'capture';
}

//SlideTopRouteBuilder
//CupertinoPageRoute

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.login:
        return FadeRouteBuilder(LoginPage());
      case RouteName.register:
        return FadeRouteBuilder(LoginPage());
      case RouteName.home:
        return FadeRouteBuilder(HomePage());
      case RouteName.capture:
        return FadeRouteBuilder(CapturePage());
      case RouteName.map:
        return FadeRouteBuilder(MapPage());
      case RouteName.code:
        return FadeRouteBuilder(CheckCodePage());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
