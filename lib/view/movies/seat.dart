import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';
import 'package:movie_app_2072046/service/movie_service.dart';
import 'package:movie_app_2072046/view/movies/detail_movie.dart';
import 'package:movie_app_2072046/widget/seat_widget.dart';
import 'package:movie_app_2072046/widget/time_widget.dart';

import '../../entity/ticket/ticket.dart';

class Seats extends ConsumerStatefulWidget {
  final int idMov;
  const Seats({super.key, required this.idMov});

  @override
  ConsumerState<Seats> createState() => _SeatsState();
}

class _SeatsState extends ConsumerState<Seats> {
  MovieDetail? _movieDetail;

  @override
  Widget build(BuildContext context) {
    // riverpod
    String? jamPilihan = ref.watch(jamProvider);
    List? kursiPilihan = ref.watch(kursiProvider);

    List<TimeOfDay> listTime = [
      const TimeOfDay(hour: 12, minute: 20),
      const TimeOfDay(hour: 13, minute: 20),
      const TimeOfDay(hour: 14, minute: 20),
      const TimeOfDay(hour: 15, minute: 20),
    ];

    DateTime datePilihan = DateTime.now();

    Future addTicket() async {
      final docTicket = FirebaseFirestore.instance.collection('tickets').doc();

      final ticket = Ticket(
          ticketId: docTicket.id,
          movId: widget.idMov,
          tanggal: datePilihan,
          jam: jamPilihan,
          kursi: kursiPilihan);

      final json = ticket.toJson();

      await docTicket
          .set(json)
          .then((value) => log("berhasil"))
          .catchError((err) => log("gagal"));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFf4C10F)),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: true,
        // ganti title
        title: FutureBuilder(
          future: MovieService().getMovieDetail(widget.idMov),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.title!,
                style: const TextStyle(color: Color(0xFFf4C10F), fontSize: 20),
              );
            } else {
              return const Text("...");
            }
          },
        ),
      ),
      body: ListView(children: [
        const SizedBox(height: 10),
        //tanggal
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime(2022, 11, 1),
          lastDate: DateTime(2023, 12, 30),
          onDateSelected: (date) {
            // ambil valuenya
            datePilihan = date;
          },
          leftMargin: 20,
          monthColor: Colors.white.withOpacity(0.6),
          dayColor: Colors.white.withOpacity(0.6),
          activeDayColor: Theme.of(context).colorScheme.primary,
          activeBackgroundDayColor: Theme.of(context).colorScheme.secondary,
          dotsColor: Theme.of(context).colorScheme.primary,
          locale: 'en_ISO',
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          // jam
          child: TimeWidget(times: listTime, id: widget.idMov),
        ),
        const SizedBox(height: 15),
        // kursi
        Container(
            margin: const EdgeInsets.only(right: 15),
            child: Image.asset('assets/images/screen.png')),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(5, (index) => SeatWidget(kode: 'A${index}')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'B${index}')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'C${index}')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'D${index}')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(5, (index) => SeatWidget(kode: 'E${index}')),
            ),
          ],
        )
      ]),
      //button
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 25),
        color: Theme.of(context).colorScheme.background,
        child: ElevatedButton(
          onPressed: () {
            log(widget.idMov.toString());
            log(datePilihan.toString());
            log(jamPilihan.toString());
            log(kursiPilihan.toString());
            addTicket();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.payment),
              SizedBox(
                width: 10,
              ),
              Text("Booking Ticket")
            ],
          ),
        ),
      ),
    );
  }
}
