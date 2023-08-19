// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/presentation/main/main_screen.dart';
import 'package:flutter_movies_app/presentation/movie/screens/movie_screen.dart';
import 'package:flutter_movies_app/presentation/splash/screens/splash_screen.dart';
import 'package:flutter_movies_app/presentation/splash/screens/web_view_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.SPLASH_SCREEN:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case RouteNames.WEB_VIEW_SCREEN:
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => WebViewScreen(
              url: args['url'],
              splashBloc: args['splashBloc'],
            ),
          );
        }
        return _errorRoute();
      case RouteNames.MOVIE_DETAILS_SCREEN:
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => MovieScreen(
              movieId: args['movieId'],
            ),
          );
        }
        return _errorRoute();
      case RouteNames.MAIN_SCREEN:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class RouteNames {
  static const SPLASH_SCREEN = '/';
  static const WEB_VIEW_SCREEN = '/web_view_screen';
  static const MAIN_SCREEN = '/main_screen';
  static const HOME_SCREEN = '/main_screen/home_screen';
  static const EXPLORE_SCREEN = '/main_screen/explore_screen';
  static const FAVORITES_SCREEN = '/main_screen/favorites_screen';
  static const MOVIE_DETAILS_SCREEN = '/movie_details_screen';
}
