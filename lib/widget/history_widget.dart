import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_2072046/widget/movie_poster.dart';

class HistoryWidget extends StatelessWidget {
  final String ticketId;
  final String title;
  final DateTime date;
  final String time;
  final MoviePoster image;
  final List<dynamic> seat;
  final VoidCallback onTap;

  const HistoryWidget(
      {super.key,
      required this.title,
      required this.date,
      required this.image,
      required this.onTap,
      required this.ticketId,
      required this.time,
      required this.seat});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      Card(
          color: (Theme.of(context).colorScheme.secondary).withOpacity(0.5),
          child: Container(
              height: 135,
              padding: const EdgeInsets.only(left: 90),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.date_range_rounded,
                              size: 18, color: Color(0xFFf4C10F)),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('E, dd-MM-yyyy').format(date),
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 25),
                          const Icon(Icons.timer_sharp,
                              size: 18, color: Color(0xFFf4C10F)),
                          const SizedBox(width: 5),
                          Text(
                            time.toString(),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.chair_outlined,
                              size: 18, color: Color(0xFFf4C10F)),
                          const SizedBox(width: 5),
                          Text(
                            seat.take(seat.length).join(", ").toString(),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ))),
      Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(padding: const EdgeInsets.all(10), child: image)),
      Container(
        margin: const EdgeInsets.only(right: 5),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: onTap,
            child: const Text(
              "Lihat Detail",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ),
    ]);
  }
}
