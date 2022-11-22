import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import 'package:movie_app_2072046/view/home_page.dart';
import 'package:movie_app_2072046/view/setting_page.dart';
import 'package:movie_app_2072046/view/ticket_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  final List pages = [
    const HomePage(),
    const TicketPage(),
    const SettingPage(),
  ];

//sementara
  @override
  void initState() {
    MovieService().getListPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: pages.elementAt(page),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_rounded),
            label: "My Ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        currentIndex: page,
        onTap: (value) => setState(() {
          page = value;
          log(value.toString());
        }),
      ),
    );
  }

//belum
  Widget loadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
              // color: primaryColor,
              ),
          SizedBox(height: 18),
          Text(
            'Loading',
          ),
        ],
      ),
    );
  }
}
