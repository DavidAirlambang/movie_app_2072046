// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'playing.freezed.dart';
part 'playing.g.dart';

@freezed
class PlayingMovie with _$PlayingMovie {
  const factory PlayingMovie({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _PlayingMovie;

  factory PlayingMovie.fromJson(Map<String, dynamic> json) =>
      _$PlayingMovieFromJson(json);
}
