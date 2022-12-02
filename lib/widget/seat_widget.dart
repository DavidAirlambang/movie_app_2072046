import 'dart:developer';

import 'package:flutter/material.dart';

class SeatWidget extends StatefulWidget {
  bool isReserved;
  bool isSelected;
  final String kode;

  SeatWidget(
      {Key? key,
      this.isSelected = false,
      this.isReserved = false,
      required this.kode})
      : super(key: key);

  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          log(widget.kode);
          !widget.isReserved ? widget.isSelected = !widget.isSelected : null;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.width / 10,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : widget.isReserved
                  ? Theme.of(context).colorScheme.primary
                  : null,
          border: !widget.isSelected && !widget.isReserved
              ? Border.all(
                  color: Theme.of(context).colorScheme.secondary, width: 1.0)
              : null,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(widget.kode),
      ),
    );
  }
}
