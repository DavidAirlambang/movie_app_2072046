import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/entity/ticket/ticket.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import 'package:movie_app_2072046/view/movies/detail_movie.dart';

import '../entity/detail/detail.dart';

var judulProvider = StateProvider<String?>((ref) => null);
final posterProvider = StateProvider<String>((ref) => '');
final jamProvider =
    StateProvider<TimeOfDay>((ref) => TimeOfDay(hour: 0, minute: 0));
final seatProvider = StateProvider<List<String>>((ref) => ['A1']);
final tanggalProvider = StateProvider<DateTime>((ref) => DateTime(2002));

final ticketProvider = StateProvider<Ticket>((ref) => Ticket());

final detailProvider =
    FutureProvider.family<MovieDetail?, int>((ref, id) async {
  return ref.read(movieProvider).getMovieDetail(id);
});

class TicketProvider {}
