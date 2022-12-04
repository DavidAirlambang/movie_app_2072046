import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/provider.dart';

class TimeWidget extends ConsumerStatefulWidget {
  final List<TimeOfDay> times;

  const TimeWidget({Key? key, required this.times})
      : super(key: key);

  @override
  ConsumerState<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends ConsumerState<TimeWidget> {
  int? selected = -1;

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          widget.times.length,
          (index) {
            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selected = index;
                  ref.read(jamProvider.notifier).state =
                      "${widget.times[index].hour.toString().padLeft(2, '0')}:${widget.times[index].minute.toString().padLeft(2, '0')}";
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: index == selected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: [
                    Text(
                      "${widget.times[index].hour.toString().padLeft(2, '0')}:${widget.times[index].minute.toString().padLeft(2, '0')}",
                      style: TextStyle(
                          color: index == selected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
