// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaksi _$TransaksiFromJson(Map<String, dynamic> json) {
  return _Transaksi.fromJson(json);
}

/// @nodoc
mixin _$Transaksi {
  int? get amount => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  Map<String, dynamic>? get movie => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransaksiCopyWith<Transaksi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransaksiCopyWith<$Res> {
  factory $TransaksiCopyWith(Transaksi value, $Res Function(Transaksi) then) =
      _$TransaksiCopyWithImpl<$Res, Transaksi>;
  @useResult
  $Res call(
      {int? amount,
      String? type,
      DateTime? date,
      String? uid,
      Map<String, dynamic>? movie});
}

/// @nodoc
class _$TransaksiCopyWithImpl<$Res, $Val extends Transaksi>
    implements $TransaksiCopyWith<$Res> {
  _$TransaksiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? type = freezed,
    Object? date = freezed,
    Object? uid = freezed,
    Object? movie = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransaksiCopyWith<$Res> implements $TransaksiCopyWith<$Res> {
  factory _$$_TransaksiCopyWith(
          _$_Transaksi value, $Res Function(_$_Transaksi) then) =
      __$$_TransaksiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? type,
      DateTime? date,
      String? uid,
      Map<String, dynamic>? movie});
}

/// @nodoc
class __$$_TransaksiCopyWithImpl<$Res>
    extends _$TransaksiCopyWithImpl<$Res, _$_Transaksi>
    implements _$$_TransaksiCopyWith<$Res> {
  __$$_TransaksiCopyWithImpl(
      _$_Transaksi _value, $Res Function(_$_Transaksi) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? type = freezed,
    Object? date = freezed,
    Object? uid = freezed,
    Object? movie = freezed,
  }) {
    return _then(_$_Transaksi(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value._movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaksi implements _Transaksi {
  const _$_Transaksi(
      {required this.amount,
      required this.type,
      required this.date,
      required this.uid,
      final Map<String, dynamic>? movie})
      : _movie = movie;

  factory _$_Transaksi.fromJson(Map<String, dynamic> json) =>
      _$$_TransaksiFromJson(json);

  @override
  final int? amount;
  @override
  final String? type;
  @override
  final DateTime? date;
  @override
  final String? uid;
  final Map<String, dynamic>? _movie;
  @override
  Map<String, dynamic>? get movie {
    final value = _movie;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Transaksi(amount: $amount, type: $type, date: $date, uid: $uid, movie: $movie)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaksi &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other._movie, _movie));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type, date, uid,
      const DeepCollectionEquality().hash(_movie));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransaksiCopyWith<_$_Transaksi> get copyWith =>
      __$$_TransaksiCopyWithImpl<_$_Transaksi>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransaksiToJson(
      this,
    );
  }
}

abstract class _Transaksi implements Transaksi {
  const factory _Transaksi(
      {required final int? amount,
      required final String? type,
      required final DateTime? date,
      required final String? uid,
      final Map<String, dynamic>? movie}) = _$_Transaksi;

  factory _Transaksi.fromJson(Map<String, dynamic> json) =
      _$_Transaksi.fromJson;

  @override
  int? get amount;
  @override
  String? get type;
  @override
  DateTime? get date;
  @override
  String? get uid;
  @override
  Map<String, dynamic>? get movie;
  @override
  @JsonKey(ignore: true)
  _$$_TransaksiCopyWith<_$_Transaksi> get copyWith =>
      throw _privateConstructorUsedError;
}
