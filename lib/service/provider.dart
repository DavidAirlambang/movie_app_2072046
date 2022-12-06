import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import '../entity/detail/detail.dart';

//simpan user
final userNow = StateProvider<User?>((ref) => null);

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

// ambil value dari selected
// jam
final jamProvider = StateProvider<String?>((ref) => null);

// kursi
final kursiProvider = StateProvider.autoDispose<List>((ref) => []);

// date
final dateProvider = StateProvider<DateTime?>((ref) => null);
