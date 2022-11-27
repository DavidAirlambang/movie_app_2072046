// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'coming.freezed.dart';
part 'coming.g.dart';

@freezed
class ComingMovie with _$ComingMovie {
  const factory ComingMovie({
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
  }) = _ComingMovie;

  factory ComingMovie.fromJson(Map<String, dynamic> json) =>
      _$ComingMovieFromJson(json);
}
