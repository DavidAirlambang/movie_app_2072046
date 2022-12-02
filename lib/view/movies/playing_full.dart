import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/service/movie_service.dart';

import '../../repository/repository.dart';

class PlayingFullMovie extends StatefulWidget {
  const PlayingFullMovie({super.key});

  @override
  State<PlayingFullMovie> createState() => _PlayingFullMovieState();
}

class _PlayingFullMovieState extends State<PlayingFullMovie> {
  Future _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFf4C10F)),
        title: const Text(
          "Now Playing Movies",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: _onRefresh,
        child: FutureBuilder(
          future: MovieService().getListPlayingMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Theme.of(context).colorScheme.background,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.all(16),
                  children: (snapshot.data ?? []).map((e) {
                    return InkWell(
                      onTap: () {
                        context.goNamed("detailMovieIn1",
                            params: {"id": e.id.toString()});
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            image: DecorationImage(
                              image: e.poster_path != null
                                  ? NetworkImage(
                                      '${MovieRepository.imageBaseURL}w500/${(e.poster_path)}',
                                    )
                                  : const AssetImage(
                                          'assets/images/img_null.png')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return Column(
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
