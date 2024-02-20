import 'package:flutter/material.dart';

import 'app_configuration.dart';

class AppRouteInformationParser extends RouteInformationParser<AppConfiguration> {
  @override
  Future<AppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final configuration = AppConfiguration.fromUri(routeInformation.uri);

    return configuration;
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    final uri = configuration.toUri();

    return RouteInformation(uri: uri);
  }
}
