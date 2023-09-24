part of bc_utils;

class AppRoutes {
  static const String wrapperRoute = '/wrapper';
  static const String initRoute = '/';
  static const String homeRoute = '/home';
  static const String uploadRoute = '/upload';
  static const String resultRoute = '/result';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initRoute:
        return _route(screen: const Loader());
      case AppRoutes.homeRoute:
        return _route(screen: const HomeScreen());
      default:
        return _route(screen: const Loader());
    }
  }

  static Route<dynamic>? _route({screen}) {
    return CupertinoPageRoute(builder: (_) => screen);
  }
}
