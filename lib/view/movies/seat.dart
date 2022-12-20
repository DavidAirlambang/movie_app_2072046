import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';
import 'package:movie_app_2072046/entity/transactions/transaction.dart';
import 'package:movie_app_2072046/service/provider.dart';
import 'package:movie_app_2072046/view/setting_page.dart';
import 'package:movie_app_2072046/widget/seat_widget.dart';
import 'package:movie_app_2072046/widget/time_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../entity/ticket/ticket.dart';

class Seats extends ConsumerStatefulWidget {
  const Seats({super.key});

  @override
  ConsumerState<Seats> createState() => _SeatsState();
}

class _SeatsState extends ConsumerState<Seats> {
  MovieDetail? _movieDetail;

  @override
  Widget build(BuildContext context) {
    // riverpod
    final jamPilihan = ref.watch(jamProvider);
    final kursiPilihan = ref.watch(kursiProvider);
    final detail = ref.watch(selectedMovie);
    final user = ref.watch(userNow);
    final dataUser = ref.watch(userProvider);
    log(user!.uid.toString());

    List<TimeOfDay> listTime = [
      const TimeOfDay(hour: 12, minute: 20),
      const TimeOfDay(hour: 13, minute: 20),
      const TimeOfDay(hour: 14, minute: 20),
      const TimeOfDay(hour: 15, minute: 20),
    ];

    DateTime datePilihan = DateTime.now();

    Future addTicket() async {
      // ticket
      final docTicket = FirebaseFirestore.instance.collection('tickets').doc();

      final ticket = Ticket(
          ticketId: docTicket.id,
          movie: detail?.toJson(),
          tanggal: datePilihan,
          jam: jamPilihan,
          kursi: kursiPilihan,
          uid: user.uid);

      final json = ticket.toJson();

      // transaction
      final docTransaction =
          FirebaseFirestore.instance.collection('transactions').doc();

      final transaction = Transaksi(
          amount: kursiPilihan.length * 50000,
          type: "buy",
          date: DateTime.now().toString(),
          uid: user.uid,
          movie: detail?.toJson());

      final jsonTran = transaction.toJson();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )));
      if (int.parse(dataUser!['wallet']) >= kursiPilihan.length * 50000) {
        // tambah tiket
        await docTicket.set(json).then(
          (value) {
            docTransaction.set(jsonTran);
            Navigator.of(context, rootNavigator: true).pop();
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Success',
              desc: "Pesanan Tiket Berhasil Dibuat",
              btnOkOnPress: () {
                context.pushNamed('main');
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {
                debugPrint('Dialog Dissmiss from callback $type');
              },
            ).show();
            // potong wallet
            ref.read(updateUserProvider({
              'wallet': (double.parse(dataUser['wallet']) -
                      kursiPilihan.length * 50000.0)
                  .round()
                  .toString()
            }));
            ref.read(kursiProvider.notifier).state.clear();
          },
        ).catchError((err) => log(err.toString()));
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Saldo Tidak Mecukupi',
          desc: 'Silahkan top up saldo anda terlebih dahulu',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            context.pushNamed('topUp');
          },
        ).show();
        ref.read(kursiProvider.notifier).state.clear();
      }
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
          title: Text(detail!.title!.toString())),
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
          child: TimeWidget(times: listTime),
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
              children: List.generate(
                  5,
                  (index) => InkWell(
                      onTap: () => setState(() {}),
                      child: SeatWidget(kode: 'A$index'))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'B$index')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'C$index')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(6, (index) => SeatWidget(kode: 'D$index')),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(5, (index) => SeatWidget(kode: 'E$index')),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // harga
      ]),
      //button
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 25),
        color: Theme.of(context).colorScheme.background,
        child: ElevatedButton(
          onPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              width: 400,
              buttonsBorderRadius: const BorderRadius.all(
                Radius.circular(2),
              ),
              dismissOnTouchOutside: true,
              dismissOnBackKeyPress: false,
              headerAnimationLoop: false,
              animType: AnimType.bottomSlide,
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Confirmation",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Your Wallet ",
                              style: TextStyle(fontSize: 16)),
                          Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(dataUser!['wallet']), 0),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Amount ",
                              style: TextStyle(fontSize: 16)),
                          Text(
                            '- ${CurrencyFormat.convertToIdr(50000 * kursiPilihan.length, 0)}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DottedLine(
                          dashColor: Theme.of(context).colorScheme.primary,
                          dashRadius: 2.0,
                          lineThickness: 2),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("After Payment ",
                              style: TextStyle(fontSize: 16)),
                          Text(
                            CurrencyFormat.convertToIdr(
                                int.parse(dataUser['wallet']) -
                                    50000 * kursiPilihan.length,
                                0),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
              ),
              showCloseIcon: true,
              btnOkOnPress: () {
                setState(() {
                  addTicket();
                  ref.read(getUserProvider);
                });
              },
              btnOkText: "Pay",
            ).show();
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
