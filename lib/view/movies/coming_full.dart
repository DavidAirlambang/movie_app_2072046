import 'package:flutter/material.dart';
import 'package:movie_app_2072046/service/movie_service.dart';

import '../../repository/repository.dart';

class ComingFullMovie extends StatefulWidget {
  const ComingFullMovie({super.key});

  @override
  State<ComingFullMovie> createState() => _ComingFullMovieState();
}

class _ComingFullMovieState extends State<ComingFullMovie> {
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
          "Coming Soon Movies",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: _onRefresh,
        child: FutureBuilder(
          future: MovieService().getListComingMovies(),
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
                  children: (snapshot.data?.toList() ?? []).map((e) {
                    return InkWell(
                      onTap: () {},
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
