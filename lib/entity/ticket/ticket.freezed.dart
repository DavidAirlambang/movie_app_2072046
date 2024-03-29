// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  String? get ticketId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get movie => throw _privateConstructorUsedError;
  String? get jam => throw _privateConstructorUsedError;
  DateTime? get tanggal => throw _privateConstructorUsedError;
  List<dynamic>? get kursi => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call(
      {String? ticketId,
      Map<String, dynamic>? movie,
      String? jam,
      DateTime? tanggal,
      List<dynamic>? kursi,
      String? uid});
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = freezed,
    Object? movie = freezed,
    Object? jam = freezed,
    Object? tanggal = freezed,
    Object? kursi = freezed,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      ticketId: freezed == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      jam: freezed == jam
          ? _value.jam
          : jam // ignore: cast_nullable_to_non_nullable
              as String?,
      tanggal: freezed == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      kursi: freezed == kursi
          ? _value.kursi
          : kursi // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$_TicketCopyWith(_$_Ticket value, $Res Function(_$_Ticket) then) =
      __$$_TicketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? ticketId,
      Map<String, dynamic>? movie,
      String? jam,
      DateTime? tanggal,
      List<dynamic>? kursi,
      String? uid});
}

/// @nodoc
class __$$_TicketCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$_Ticket>
    implements _$$_TicketCopyWith<$Res> {
  __$$_TicketCopyWithImpl(_$_Ticket _value, $Res Function(_$_Ticket) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = freezed,
    Object? movie = freezed,
    Object? jam = freezed,
    Object? tanggal = freezed,
    Object? kursi = freezed,
    Object? uid = freezed,
  }) {
    return _then(_$_Ticket(
      ticketId: freezed == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value._movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      jam: freezed == jam
          ? _value.jam
          : jam // ignore: cast_nullable_to_non_nullable
              as String?,
      tanggal: freezed == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      kursi: freezed == kursi
          ? _value._kursi
          : kursi // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ticket implements _Ticket {
  const _$_Ticket(
      {this.ticketId,
      final Map<String, dynamic>? movie,
      this.jam,
      this.tanggal,
      final List<dynamic>? kursi,
      this.uid})
      : _movie = movie,
        _kursi = kursi;

  factory _$_Ticket.fromJson(Map<String, dynamic> json) =>
      _$$_TicketFromJson(json);

  @override
  final String? ticketId;
  final Map<String, dynamic>? _movie;
  @override
  Map<String, dynamic>? get movie {
    final value = _movie;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? jam;
  @override
  final DateTime? tanggal;
  final List<dynamic>? _kursi;
  @override
  List<dynamic>? get kursi {
    final value = _kursi;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? uid;

  @override
  String toString() {
    return 'Ticket(ticketId: $ticketId, movie: $movie, jam: $jam, tanggal: $tanggal, kursi: $kursi, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ticket &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            const DeepCollectionEquality().equals(other._movie, _movie) &&
            (identical(other.jam, jam) || other.jam == jam) &&
            (identical(other.tanggal, tanggal) || other.tanggal == tanggal) &&
            const DeepCollectionEquality().equals(other._kursi, _kursi) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ticketId,
      const DeepCollectionEquality().hash(_movie),
      jam,
      tanggal,
      const DeepCollectionEquality().hash(_kursi),
      uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      __$$_TicketCopyWithImpl<_$_Ticket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TicketToJson(
      this,
    );
  }
}

abstract class _Ticket implements Ticket {
  const factory _Ticket(
      {final String? ticketId,
      final Map<String, dynamic>? movie,
      final String? jam,
      final DateTime? tanggal,
      final List<dynamic>? kursi,
      final String? uid}) = _$_Ticket;

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$_Ticket.fromJson;

  @override
  String? get ticketId;
  @override
  Map<String, dynamic>? get movie;
  @override
  String? get jam;
  @override
  DateTime? get tanggal;
  @override
  List<dynamic>? get kursi;
  @override
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      throw _privateConstructorUsedError;
}
