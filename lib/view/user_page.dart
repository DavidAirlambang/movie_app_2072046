import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_2072046/entity/detail/detail.dart';
import 'package:movie_app_2072046/entity/transactions/transaction.dart';
import 'package:movie_app_2072046/service/transaction_provider.dart';
import 'package:movie_app_2072046/widget/user_widget.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    // riverpod
    final data = ref.watch(transactionStreamProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // kartu
      body: ListView(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            UserWidget(),
          ]),
          Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.81,
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "Transactions History",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  data.when(
                    data: (data) {
                      return SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return TransactionItem(objek: data[index]);
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      log(error.toString());
                      return const SizedBox();
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}

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
