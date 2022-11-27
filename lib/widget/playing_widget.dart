import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/service/movie_service.dart';

import '../repository/repository.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: (MovieService().getListPlayingMovies()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 15, 16, 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: () {
                  context.goNamed("playingFull");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Now Playing Movies",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFf4C10F)),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFFf4C10F),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 170,
                width: double.infinity,
                child: ListView(
                  padding: const EdgeInsets.only(top: 5, right: 8),
                  scrollDirection: Axis.horizontal,
                  children: (snapshot.data?.take(10).toList() ?? []).map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          context.goNamed("detailMovie",
                              params: {"id": e.id.toString()});
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 110,
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
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              )
            ]),
          );
        } else {
          return Column(
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            ],
          );
        }
      },
    );
  }
}

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
