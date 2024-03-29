import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repository/repository.dart';
import '../service/movie_service.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieService().getListPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                items: (snapshot.data ?? [])
                    .map((e) => InkWell(
                          onTap: (() {
                            context.pushNamed("detailMovie",
                                params: {"id": e.id.toString()});
                          }),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              image: DecorationImage(
                                image: e.backdrop_path != null
                                    ? NetworkImage(
                                        '${MovieRepository.imageBaseURL}w500/${(e.backdrop_path)}')
                                    : NetworkImage(
                                            '${MovieRepository.imageBaseURL}w500/${(e.poster_path)}')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 240,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, carouselReason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(index),
                    child: Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
