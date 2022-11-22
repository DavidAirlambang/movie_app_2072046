import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movie_app_2072046/entity/popular/popular.dart';
import 'package:movie_app_2072046/repository/repository.dart';

class MovieService {
  String baseUrl = MovieRepository.mainUrl;
  String imageBaseUrl = MovieRepository.imageBaseURL;
  String apiKey = MovieRepository.key;
  String language = MovieRepository.language;
  String region = MovieRepository.region;
  var dio = Dio();

  //Popular
  Future<List<PopularMovie>?> getListPopularMovies() async {
    Dio dio = Dio();
    String url =
        '$baseUrl/movie/popular?api_key=$apiKey&language=$language&page=1';
    try {
      var result = await dio.get(url);

      // log((result.data['results'] as List).toString());

      List<PopularMovie> populars = (result.data['results'] as List)
          .map((e) => PopularMovie.fromJson(e))
          .toList();
      return populars;
    } catch (e) {
      return null;
    }
  }

  //Now Playing
  Future<List<PopularMovie>?> getListPlayingMovies() async {
    Dio dio = Dio();
    String url =
        '$baseUrl/movie/now_playing?api_key=$apiKey&language=$language&page=1region=$region';
    try {
      var result = await dio.get(url);

      log((result.data['results'] as List).toString());

      List<PopularMovie> playings = (result.data['results'] as List)
          .map((e) => PopularMovie.fromJson(e))
          .toList();
      return playings;
    } catch (e) {
      return null;
    }
  }

  //end
}
