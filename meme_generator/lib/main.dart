import 'package:flutter/material.dart';
import 'src/navigation/app_navigation/app_route_information_parser.dart';
import 'src/navigation/app_navigation/app_route_information_provider.dart';
import 'src/navigation/app_navigation/app_router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatefulWidget {
  /// Constructor for [MyApp].
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = AppRouterDelegate();
  final _routeInformationParser = AppRouteInformationParser();
  final _routeInformationProvider = AppRouteInformationProvider();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      routeInformationProvider: _routeInformationProvider,
    );
}
