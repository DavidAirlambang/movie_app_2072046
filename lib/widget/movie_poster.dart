import 'package:flutter/material.dart';

import '../repository/repository.dart';

class MoviePoster extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  const MoviePoster(
      {super.key,
      required this.path,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
              '${MovieRepository.imageBaseURL}w500/${path}',
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
