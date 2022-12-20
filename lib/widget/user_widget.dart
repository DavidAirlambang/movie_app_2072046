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
      margin: const EdgeInsets.only(top: 20),
      height: 220,
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade600,
                    // image: DecorationImage(
                    //   image: AssetImage("assets/Avatar.png"),
                    // ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  dataUser!['username'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 25),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Saldo Anda",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 28),
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
                ],
              ),
              Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(right: 20, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  color: Colors.transparent,
                ),
                child: IconButton(
                  onPressed: () {
                    context.pushNamed('topUp');
                  },
                  style: ElevatedButton.styleFrom(),
                  icon: Icon(
                    Icons.add,
                    size: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
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
