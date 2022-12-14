import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import '../entity/detail/detail.dart';
import '../entity/ticket/ticket.dart';

// USER PROVIDER
//simpan user
final userNow =
    StateProvider<User?>((ref) => FirebaseAuth.instance.currentUser);

// data user
final getUserProvider = FutureProvider.autoDispose(
  (ref) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(ref.read(userNow)!.uid)
        .get()
        .then((value) {
      ref.read(userProvider.notifier).state = value.data();
    });
  },
);
final userProvider = StateProvider<Map?>((ref) => null);

// update user
final updateUserProvider = FutureProvider.family(
  (ref, update) {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(ref.read(userNow)!.uid);

    // isi filednya harus map -> {'nama' : isi}
    docUser.update(update as Map<String, Object?>);
  },
);

final dataTest = StateProvider((ref) => null);
// .map((snapshot) => snapshot.data());

/// MOVIE PROVIDER
// Ambil Movie Service
final movieProvider = Provider<MovieService>((ref) => MovieService());

// ambil detail dari movie -> masukin selected
final movieDetailProvider = FutureProvider.family<MovieDetail?, int>(
  (ref, id) async {
    final data = ref.watch(movieProvider).getMovieDetail(id);
    ref.watch(selectedMovie.notifier).state = await data;
    return data;
  },
);
// data movie yang udh dipilih
final selectedMovie = StateProvider<MovieDetail?>((ref) => null);

// VARIABLE GLOBAL
// jam
final jamProvider = StateProvider<String?>((ref) => null);

// kursi
final kursiProvider = StateProvider.autoDispose<List>((ref) => []);

// date
final dateProvider = StateProvider<DateTime?>((ref) => null);

// TICKET PROVIDER
// get Ticket
final ticketStreamProvider = StreamProvider(
  (ref) {
    final user = ref.watch(userNow);

    final things = FirebaseFirestore.instance
        .collection('tickets')
        .where('uid', isEqualTo: user!.uid)
        .orderBy('tanggal', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
    return things;
  },
);

// get one ticket
final oneTicketObjectProvider = StateProvider<Ticket?>((ref) => null);
