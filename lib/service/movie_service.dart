import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/entity/coming/coming.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';
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
      return populars.take(5).toList();
    } on DioError catch (e) {
      log(e.response.toString());
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

      // log((result.data['results'] as List).toString());

      List<PopularMovie> playings = (result.data['results'] as List)
          .map((e) => PopularMovie.fromJson(e))
          .toList();
      return playings;
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  //Coming Soon
  Future<List<ComingMovie>?> getListComingMovies() async {
    Dio dio = Dio();
    String url =
        '$baseUrl/movie/upcoming?api_key=$apiKey&language=$language&page=1&region=US';
    try {
      var result = await dio.get(url);

      // log((result.data['results'] as List).toString());

      List<ComingMovie> comings = (result.data['results'] as List)
          .map((e) => ComingMovie.fromJson(e))
          .toList();
      return comings;
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  //Detail Movie
  Future<MovieDetail?> getMovieDetail(int id) async {
    Dio dio = Dio();
    String url = '$baseUrl/movie/$id?api_key=$apiKey&language=$language';
    ;
    try {
      var result = await dio.get(url);

      // log((result.data).toString());

      MovieDetail movieDetail = MovieDetail.fromJson(result.data);
      return movieDetail;
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  //end
}



