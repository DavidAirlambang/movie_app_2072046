// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ticket _$$_TicketFromJson(Map<String, dynamic> json) => _$_Ticket(
      ticketId: json['ticketId'] as String?,
      movie: json['movie'] as Map<String, dynamic>?,
      jam: json['jam'] as String?,
      tanggal: json['tanggal'] == null
          ? null
          : DateTime.parse(json['tanggal'] as String),
      kursi: json['kursi'] as List<dynamic>?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$$_TicketToJson(_$_Ticket instance) => <String, dynamic>{
      'ticketId': instance.ticketId,
      'movie': instance.movie,
      'jam': instance.jam,
      'tanggal': instance.tanggal?.toIso8601String(),
      'kursi': instance.kursi,
      'uid': instance.uid,
    };
