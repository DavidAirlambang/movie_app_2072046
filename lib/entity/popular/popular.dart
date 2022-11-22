// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular.freezed.dart';
part 'popular.g.dart';

@freezed
class PopularMovie with _$PopularMovie {
  const factory PopularMovie(
      {bool? adult,
      String? backdrop_path,
      List<int>? genre_ids,
      int? id,
      String? original_language,
      String? original_title,
      String? overview,
      double? popularity,
      String? poster_path,
      DateTime? release_date,
      String? title,
      bool? video,
      double? vote_average,
      int? vote_count}) = _PopularMovie;

  factory PopularMovie.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieFromJson(json);
}
