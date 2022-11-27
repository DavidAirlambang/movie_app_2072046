// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieDetail _$$_MovieDetailFromJson(Map<String, dynamic> json) =>
    _$_MovieDetail(
      adult: json['adult'] as bool?,
      backdrop_path: json['backdrop_path'] as String?,
      budget: json['budget'] as int?,
      production_companies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      id: json['id'] as int?,
      original_language: json['original_language'] as String?,
      original_title: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      poster_path: json['poster_path'] as String?,
      release_date: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      vote_count: json['vote_count'] as int?,
    );

Map<String, dynamic> _$$_MovieDetailToJson(_$_MovieDetail instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'budget': instance.budget,
      'production_companies': instance.production_companies,
      'genres': instance.genres,
      'id': instance.id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'release_date': instance.release_date?.toIso8601String(),
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
