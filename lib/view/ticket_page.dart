import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';
import 'package:movie_app_2072046/widget/history_widget.dart';
import 'package:movie_app_2072046/widget/movie_poster.dart';

import '../entity/ticket/ticket.dart';
import '../repository/repository.dart';
import '../service/provider.dart';
import '../widget/ticket_detail_widget.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // riverpod
    final data = ref.watch(ticketStreamProvider);
    var oneTicket = ref.watch(oneTicketObjectProvider.notifier).state;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text(
            "History",
            style: TextStyle(color: Color(0xFFf4C10F), fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: data.when(
            data: (data) {
              List<Ticket>? read = ref.watch(ticketStreamProvider).value;

              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final movie = read?[index].movie;
                    MovieDetail movieTicket = MovieDetail.fromJson(movie!);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HistoryWidget(
                        title: movieTicket.title.toString(),
                        image: MoviePoster(
                          path:
                              '${MovieRepository.imageBaseURL}w500/${movieTicket.poster_path}',
                          height: 140,
                          width: 90,
                        ),
                        onTap: () {
                          oneTicket = read[index];
                          ticketDetail(context, oneTicket);
                        },
                        date: read![index].tanggal as DateTime,
                        ticketId: read[index].ticketId.toString(),
                        time: read[index].jam.toString(),
                        seat: read[index].kursi as List,
                      ),
                    );

                    // sampe sini
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              log(error.toString());
            },
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
