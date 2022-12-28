import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/detail/detail.dart';
import '../entity/transactions/transaction.dart';
import '../repository/repository.dart';

class TransactionItem extends StatelessWidget {
  final Transaksi objek;
  const TransactionItem({
    Key? key,
    required this.objek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = objek.type;
    MovieDetail? movie;

    if (type == "buy") {
      movie = MovieDetail.fromJson(objek.movie!);
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(),
                SizedBox(
                  width: 180,
                  height: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        (type == "buy") ? movie!.title.toString() : "Top Up",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('E, dd-MM-yyyy hh:mm:ss')
                            .format(DateTime.parse(objek.date.toString())),
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            (type == "buy")
                ? '- ${CurrencyFormat.convertToIdr(objek.amount, 0)}'
                : '+ ${CurrencyFormat.convertToIdr(objek.amount, 0)}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: (type == "buy") ? Colors.red : Colors.green),
          ),
        ],
      ),
    );
  }
}
