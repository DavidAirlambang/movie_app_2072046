import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MoveRepository {
  final String key = "918f5ec196f2e90bdde212aba071344d";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MThmNWVjMTk2ZjJlOTBiZGRlMjEyYWJhMDcxMzQ0ZCIsInN1YiI6IjYyYmE2ZmY1MTJhYWJjMDA5NWUwY2E5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Sx7XRCdOHlIG_E4sjTPMOAcI1Hz4eTIqtTB_EEdwDhs";

  getMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(key, token),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trending = await tmdbWithCustomLogs.v3.trending.getTrending();
    print(trending);
  }
}
