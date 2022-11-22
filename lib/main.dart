import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/view/login_page.dart';
import 'package:movie_app_2072046/view/main_page.dart';
import 'package:movie_app_2072046/view/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xFFf4C10F),
  secondary: Color(0xFF5a606b),
  surface: Color(0xFF151C26),
  background: Color(0xFF151C26),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/signIn',
      name: 'signIn',
      builder: (context, state) => Login(),
    ),
    GoRoute(
        path: '/sign_up',
        name: 'signUp',
        builder: (context, state) => const SignUp(
              title: 'Movie App',
            )),
    GoRoute(
        path: '/main_page',
        name: 'main',
        builder: (context, state) => const MainPage()),
  ], initialLocation: '/signIn');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        primarySwatch: Colors.blue,
      ),
    );
  }
}
