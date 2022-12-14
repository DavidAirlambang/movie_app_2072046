import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../service/provider.dart';

class UserWidget extends ConsumerWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //riverpod
    final dataUser = ref.watch(userProvider);
    return Container(
      height: 205,
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, bottom: 12),
            child: Text(
              dataUser!['username'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 25),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Saldo Anda",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 28),
            child: Row(
              children: [
                Text(
                  CurrencyFormat.convertToIdr(
                      int.tryParse(dataUser['wallet']) ?? 0, 2),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('topUp');
                },
                style: ElevatedButton.styleFrom(),
                child: const Text("Top Up"),
              ),
            ),
          ),
          //batas column
        ]),
      ),
    );
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
