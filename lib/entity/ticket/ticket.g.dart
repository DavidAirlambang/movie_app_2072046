// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ticket _$$_TicketFromJson(Map<String, dynamic> json) => _$_Ticket(
      judul: json['judul'] as String?,
      jam: json['jam'] as String?,
      tanggal: json['tanggal'] == null
          ? null
          : DateTime.parse(json['tanggal'] as String),
      kursi: json['kursi'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_TicketToJson(_$_Ticket instance) => <String, dynamic>{
      'judul': instance.judul,
      'jam': instance.jam,
      'tanggal': instance.tanggal?.toIso8601String(),
      'kursi': instance.kursi,
    };
