// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'playing.freezed.dart';
part 'playing.g.dart';

@freezed
class PlayingMovie with _$PlayingMovie {
  const factory PlayingMovie({
    bool? adult,
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
    int? vote_count,
  }) = _PlayingMovie;

  factory PlayingMovie.fromJson(Map<String, dynamic> json) =>
      _$PlayingMovieFromJson(json);
}
