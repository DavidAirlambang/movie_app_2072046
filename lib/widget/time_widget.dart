import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimeWidget extends StatefulWidget {
  final List<TimeOfDay> times;
  int? id;
  int? pilihan;

  TimeWidget({Key? key, required this.times, required this.id, this.pilihan})
      : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  int? selected;

  @override
  void initState() {
    selected = widget.pilihan;
  }

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
                  context.pushNamed("seats", params: {
                    "id": widget.id.toString(),
                    "idMov": widget.id.toString(),
                    "time": TimeOfDay(
                            hour: widget.times[index].hour,
                            minute: widget.times[index].minute)
                        .toString()
                  });
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
