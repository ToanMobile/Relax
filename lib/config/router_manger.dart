import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/ui/screen/home/home.dart';
import 'package:relax/ui/screen/listoffer/list_offer_page.dart';
import 'package:relax/ui/screen/login/login_page.dart';
import 'package:relax/ui/screen/map/driver/capture/capture_page.dart';
import 'package:relax/ui/screen/map/driver/code/check_code_page.dart';
import 'package:relax/ui/screen/map/map_page.dart';
import 'package:relax/ui/screen/offerdetails/offer_details_page.dart';
import 'package:relax/ui/screen/register/register_page.dart';
import 'package:relax/ui/screen/register/register_success_page.dart';
import 'package:relax/ui/widget/page_route_anim.dart';
import 'package:relax/viewmodel/home_model.dart';

class RouteName {
  static const String home = '/';
  static const String list_offer = 'list_offer';
  static const String offer_details = 'offer_details';
  static const String login = 'login';
  static const String register = 'register';
  static const String register_success = 'register_success';
  static const String driver = 'driver';
  static const String shipper = 'shipper';
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
        return FadeRouteBuilder(RegisterPage());
      case RouteName.register_success:
        return FadeRouteBuilder(RegisterSuccessPage());
      case RouteName.home:
        return FadeRouteBuilder(HomePage());
      case RouteName.list_offer:
        return FadeRouteBuilder(ListOfferPage());
      case RouteName.offer_details:
        return FadeRouteBuilder(OfferDetailsPage(offerInfoEntity: settings.arguments));
      case RouteName.capture:
        return FadeRouteBuilder(CapturePage());
      case RouteName.driver:
        return FadeRouteBuilder(MapPage(ROLE.DRIVER));
      case RouteName.shipper:
        return FadeRouteBuilder(MapPage(ROLE.SHIPPER));
      case RouteName.code:
        return FadeRouteBuilder(CheckCodePage(driverEntity: settings.arguments));
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
