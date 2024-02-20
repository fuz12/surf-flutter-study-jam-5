import 'dart:ui' show AppExitResponse, PlatformDispatcher;

import 'package:flutter/material.dart';

class AppRouteInformationProvider extends PlatformRouteInformationProvider {
  AppRouteInformationProvider() : super(
    initialRouteInformation: RouteInformation(uri: Uri.parse(PlatformDispatcher.instance.defaultRouteName))
  );

  @override
  Future<void> didChangeLocales(List<Locale>? locales) async {
    super.didChangeLocales(locales);
  }

  @override
  Future<bool> didPopRoute() async {
    final didPop = await super.didPopRoute();

    return didPop;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) async {
    final didPush = await super.didPushRouteInformation(routeInformation);

    return didPush;
  }
  
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    final exitResponse = await super.didRequestAppExit();

    return exitResponse;
  }

}
