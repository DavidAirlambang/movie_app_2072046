import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/detail/detail.dart';
import '../entity/ticket/ticket.dart';
import '../repository/repository.dart';

Future<dynamic> ticketDetail(BuildContext context, Ticket? oneTicket) {
  final posterMovie = MovieDetail.fromJson(oneTicket!.movie!).poster_path;
  return showDialog(
    context: context,
    builder: (context) {
      return Material(
        color: Colors.black.withOpacity(0.6),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Center(
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: TicketsClipper(),
              child: Container(
                width: 300,
                height: 550,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 390,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage(
                                '${MovieRepository.imageBaseURL}w500/$posterMovie',
                              ),
                              fit: BoxFit.cover)),
                    ),
                    const DottedLine(
                        dashColor: Colors.grey,
                        dashRadius: 2.0,
                        lineThickness: 2),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.date_range_rounded,
                                        size: 20, color: Color(0xFFf4C10F)),
                                    const SizedBox(width: 5),
                                    Text(
                                      DateFormat('EEEE, dd-MM-yyyy')
                                          .format(oneTicket.tanggal!),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.timer_sharp,
                                        size: 20, color: Color(0xFFf4C10F)),
                                    const SizedBox(width: 5),
                                    Text(
                                      oneTicket.jam!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.chair_outlined,
                                        size: 24, color: Color(0xFFf4C10F)),
                                    const SizedBox(width: 5),
                                    const SizedBox(height: 5),
                                    Text(
                                      oneTicket.kursi!
                                          .take(oneTicket.kursi!.length)
                                          .join(", ")
                                          .toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 60,
                                  width: 250,
                                  child: BarcodeWidget(
                                    style: const TextStyle(fontSize: 10),
                                    width: 2,
                                    color: const Color(0xFFf4C10F),
                                    barcode: Barcode.code128(),
                                    data: oneTicket.ticketId.toString(),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class TicketsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 1.4), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 1.4), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
