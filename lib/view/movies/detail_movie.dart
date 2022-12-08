import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import 'package:movie_app_2072046/widget/movie_poster.dart';

import '../../repository/repository.dart';
import '../../service/provider.dart';

class DetailMovie extends ConsumerWidget {
  final int id;
  const DetailMovie({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(movieProvider).getMovieDetail(id);
    List genres = [];
    int length = 0;

    // riverpod
    final detail = ref.watch(movieDetailProvider(id));

    //statusbar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    //view
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFf4C10F)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: MovieService().getMovieDetail(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            length = snapshot.data!.genres!.length;

            for (var element in snapshot.data!.genres!) {
              genres.add(element['name']);
            }
            return Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Image(
                              image: snapshot.data!.backdrop_path != null
                                  ? NetworkImage(
                                      '${MovieRepository.imageBaseURL}original/${(snapshot.data!.backdrop_path)}')
                                  : NetworkImage(
                                          '${MovieRepository.imageBaseURL}original/${(snapshot.data!.poster_path)}')
                                      as ImageProvider,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              left: 16,
                              top: 200,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MoviePoster(
                                    path: snapshot.data!.poster_path!,
                                    height: 180,
                                    width: 120,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            snapshot.data!.title!,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        dataMovie(
                                          "Year           ",
                                          snapshot.data!.release_date
                                              .toString()
                                              .substring(0, 4),
                                        ),
                                        const SizedBox(height: 5),
                                        dataMovie(
                                            "Production",
                                            snapshot
                                                .data!
                                                .production_companies![0]
                                                    ['name']
                                                .toString()),
                                        const SizedBox(height: 5),
                                        dataMovie(
                                            "Origin         ",
                                            snapshot
                                                .data!
                                                .production_companies![0]
                                                    ['origin_country']
                                                .toString()),
                                        const SizedBox(height: 5),
                                        dataMovie(
                                            "Genres      ",
                                            genres
                                                .take(length)
                                                .join(", ")
                                                .toString())
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Positioned(
                            top: 420,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.2),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          children:
                                              List<Icon>.generate(5, (index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 12,
                                            );
                                          }),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${snapshot.data!.vote_average!.toString().substring(0, 3)}/10",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                    ),
                                    boxInfo("Run Time",
                                        "${snapshot.data!.runtime} Min"),
                                    boxInfo("Status",
                                        snapshot.data!.status.toString())
                                  ],
                                )
                              ]),
                            ),
                          ),
                          Positioned(
                            top: 510,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Synopsis",
                                    style: TextStyle(
                                      fontSize: 21,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 330,
                                    child: Text(
                                      snapshot.data!.overview!,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(height: 1.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            );
          }
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 25),
        color: Theme.of(context).colorScheme.background,
        child: ElevatedButton(
          onPressed: () {
            context.goNamed("seats", params: {"id": id.toString()});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add),
              SizedBox(
                width: 10,
              ),
              Text("Tambah Tiket")
            ],
          ),
        ),
      ),
    );
  }
}

Widget dataMovie(String type, var release) {
  return Row(
    children: [
      Text(
        type,
        style: const TextStyle(color: Color(0xFF5a606b), fontSize: 16),
      ),
      const SizedBox(width: 20),
      SizedBox(
        width: 140,
        child: Text(
          release,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          maxLines: 2,
        ),
      )
    ],
  );
}

Widget boxInfo(String judul, String isi) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    height: 60,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    decoration: BoxDecoration(
        border: Border.all(
            color: const Color(0xFFf4C10F).withOpacity(0.2), width: 2),
        borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Text(
        judul,
        style: const TextStyle(fontSize: 16, color: Color(0xFF5a606b)),
      ),
      const Spacer(),
      Text(
        isi,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
    ]),
  );
}
