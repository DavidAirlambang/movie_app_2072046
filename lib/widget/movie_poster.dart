import 'package:flutter/material.dart';

import '../repository/repository.dart';

class MoviePoster extends StatelessWidget {
  final String path;
  const MoviePoster({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 120,
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
