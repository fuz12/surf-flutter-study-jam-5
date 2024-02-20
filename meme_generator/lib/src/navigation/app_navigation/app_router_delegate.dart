import 'package:flutter/material.dart';
import '../../presentation/screens/meme_generator_screen.dart';

import '../page_builders/material_page_builder.dart';
import 'app_configuration.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier {
  AppRouterDelegate();

  @override
  Widget build(BuildContext context) => Navigator(
      onPopPage: _handleNavigatorPop,
      pages: <Page<void>>[
        asMaterialPage(const MemeGeneratorScreen(), 'Meme_Generator_Screen'),
        // if (isTransition)
        //   asMaterialPage(const TransitionPage(), 'Transition_Page'),
      ],
    );

  // Go back one level in our state if possible
  // true means we handled it
  // false lets the whole app go into background
  bool _tryGoBack() {
    // if (_appState.isTransition) {
    //   _appState.isTransition = false;
    //   return true;
    // }

    return false;
  }

  // Handle Navigator.pop for any routes in our stack
  bool _handleNavigatorPop(Route<void> route, void result) {
    // Ask the route if it can handle pop internally...
    if (route.didPop(result)) {
      // If not, we pop one level in our stack
      return _tryGoBack();
    }
    return false;
  }

  @override
  Future<bool> popRoute() async => _tryGoBack();

  @override
  Future<void> setInitialRoutePath(AppConfiguration configuration) async {
    await setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(AppConfiguration configuration) async {

    // if (configuration.isTransition) {
    //   _appState.isTransition = configuration.isTransition;

    //   notifyListeners();
    // }
  }
}
