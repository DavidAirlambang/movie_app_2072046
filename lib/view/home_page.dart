import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/carousel_widget.dart';
import '../widget/coming_widget.dart';
import '../widget/playing_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(color: Color(0xFFf4C10F)),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            context.goNamed('signIn');
          },
          child: const Icon(
            Icons.logout,
            color: Color(0xFFf4C10F),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        child: ListView(children: const [
          Carousel(),
          NowPlaying(),
          ComingSoon(),
        ]),
      ),
    );
  }
}
