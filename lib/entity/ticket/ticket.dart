import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket(
      {String? ticketId,
      Map<String, dynamic>? movie,
      String? jam,
      DateTime? tanggal,
      List? kursi,
      String? uid}) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
