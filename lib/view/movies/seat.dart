import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_2072046/widget/seat_widget.dart';
import 'package:movie_app_2072046/widget/time_widget.dart';

class Seats extends StatefulWidget {
  final int idMov;
  final TimeOfDay timePilihan;
  const Seats({super.key, required this.idMov, required this.timePilihan});

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  @override
  Widget build(BuildContext context) {
    List<TimeOfDay> listTime = [
      const TimeOfDay(hour: 12, minute: 20),
      const TimeOfDay(hour: 13, minute: 20),
      const TimeOfDay(hour: 14, minute: 20),
      const TimeOfDay(hour: 15, minute: 20),
    ];

    final ambilIndex = listTime.indexOf(widget.timePilihan);
    log(ambilIndex.toString());

    DateTime datePilihan = DateTime.now();

    bool isReserved = false;

    bool isSelected = false;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: true,
        // ganti title
        title: Text(widget.idMov.toString()),
      ),
      body: ListView(children: [
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
        const SizedBox(height: 5),
        SizedBox(
          height: 80,
          // jam
          child: TimeWidget(
              times: listTime, id: widget.idMov, pilihan: ambilIndex),
        ),
        const SizedBox(height: 10),
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
            log(datePilihan.toString());
            log(widget.timePilihan.toString());
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
