import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kursiProvider = StateProvider.autoDispose<List>((ref) => []);

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
    List sementara = ref.read(kursiProvider.notifier).state;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          sementara.contains(widget.kode)
              ? sementara.removeWhere((element) => element == widget.kode)
              : sementara.add(widget.kode);

          log(sementara.toString());
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
