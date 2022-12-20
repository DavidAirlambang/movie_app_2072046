import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaksi with _$Transaksi {
  const factory Transaksi(
      {required int? amount,
      required String? type,
      required DateTime? date,
      required String? uid,
      Map<String, dynamic>? movie}) = _Transaksi;

  factory Transaksi.fromJson(Map<String, dynamic> json) =>
      _$TransaksiFromJson(json);
}
