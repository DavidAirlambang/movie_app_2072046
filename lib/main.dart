import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/view/top_up_page.dart';
import 'package:movie_app_2072046/view/user_edit_page.dart';
import 'package:movie_app_2072046/widget/notif.dart';
import 'package:movie_app_2072046/view/login_signUp/login_page.dart';

import 'package:movie_app_2072046/view/main_page.dart';
import 'package:movie_app_2072046/view/movies/coming_full.dart';
import 'package:movie_app_2072046/view/movies/detail_movie.dart';
import 'package:movie_app_2072046/view/movies/playing_full.dart';
import 'package:movie_app_2072046/view/movies/seat.dart';
import 'package:movie_app_2072046/view/login_signUp/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
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

class MyApp extends ConsumerStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  final GoRouter router = GoRouter(
      routes: [
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
            builder: (context, state) => const MainPage(),
            routes: [
              GoRoute(
                  path: 'playing_full',
                  name: 'playingFull',
                  builder: (context, state) => const PlayingFullMovie(),
                  routes: [
                    GoRoute(
                        path: 'detail_movie/:id',
                        name: 'detailMovieIn1',
                        builder: (context, state) {
                          return DetailMovie(
                              id: int.parse(state.params['id']!));
                        })
                  ]),
              GoRoute(
                  path: 'coming_full',
                  name: 'comingFull',
                  builder: (context, state) => const ComingFullMovie(),
                  routes: [
                    GoRoute(
                      path: 'detail_movie/:id',
                      name: 'detailMovieIn2',
                      builder: (context, state) {
                        return DetailMovie(id: int.parse(state.params['id']!));
                      },
                    ),
                  ]),
              GoRoute(
                  path: 'detail_movie/:id',
                  name: 'detailMovie',
                  builder: (context, state) {
                    return DetailMovie(id: int.parse(state.params['id']!));
                  },
                  routes: [
                    GoRoute(
                      path: 'seats',
                      name: 'seats',
                      builder: (context, state) => const Seats(),
                    ),
                  ]),
              GoRoute(
                path: 'topUp',
                name: 'topUp',
                builder: (context, state) => const TopUp(),
              ),
              GoRoute(
                path: 'userEdit',
                name: 'userEdit',
                builder: (context, state) => const UserEdit(),
              ),
            ]),
      ],
      initialLocation:
          FirebaseAuth.instance.currentUser != null ? '/main_page' : '/signIn');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      scaffoldMessengerKey: Notif.messengerKey,
      theme: ThemeData(
        colorScheme: defaultColorScheme,
      ),
    );
  }
}
