// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaksi _$$_TransaksiFromJson(Map<String, dynamic> json) => _$_Transaksi(
      amount: json['amount'] as int?,
      type: json['type'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      uid: json['uid'] as String?,
      movie: json['movie'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_TransaksiToJson(_$_Transaksi instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
      'date': instance.date?.toIso8601String(),
      'uid': instance.uid,
      'movie': instance.movie,
    };
