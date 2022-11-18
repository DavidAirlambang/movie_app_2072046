import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/repository/repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<dynamic> test = MoveRepository().getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Home Page",
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            context.goNamed('signIn');
          },
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        child: ListView(
          children: [Text(test.toString()), Text("Ini bagi genre")],
        ),
      ),
    );
  }
}
