import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/provider.dart';

class SeatWidget extends ConsumerStatefulWidget {
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
  ConsumerState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends ConsumerState<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    List kursi = ref.watch(kursiProvider.notifier).state;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          kursi.contains(widget.kode)
              ? kursi.removeWhere((element) => element == widget.kode)
              : kursi.add(widget.kode);
          !widget.isReserved ? widget.isSelected = !widget.isSelected : null;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.width / 10,
        decoration: BoxDecoration(
          color: widget.isSelected || kursi.contains(widget.kode)
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
