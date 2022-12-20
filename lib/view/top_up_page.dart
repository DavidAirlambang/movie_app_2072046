import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_2072046/service/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../entity/transactions/transaction.dart';
import '../widget/user_widget.dart';

class TopUp extends ConsumerStatefulWidget {
  const TopUp({super.key});

  @override
  ConsumerState<TopUp> createState() => _TopUpState();
}

class _TopUpState extends ConsumerState<TopUp> {
  double _value = 0.0;
  int? selected = -1;
  late double topUped;

  List<double> instant = [
    20000.0,
    50000.0,
    100000.0,
    150000.0,
    200000.0,
    250000.0
  ];

  @override
  Widget build(BuildContext context) {
    Future createTransaction() async {
      final docTransaction =
          FirebaseFirestore.instance.collection('transactions').doc();

      final transaction = Transaksi(
        amount: topUped.round(),
        type: "Top Up",
        date: DateTime.now(),
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      final jsonTran = transaction.toJson();

      await docTransaction.set(jsonTran);
    }

    final dataUser = ref.watch(userProvider);
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 25),
        color: Theme.of(context).colorScheme.background,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              ref.read(updateUserProvider({
                'wallet': (double.parse(dataUser!['wallet']) + topUped)
                    .round()
                    .toString()
              }));
            });

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    )));

            createTransaction().then(
              (value) {
                Navigator.of(context, rootNavigator: true).pop();
                AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.success,
                  showCloseIcon: true,
                  title: 'Success',
                  desc: "Top Up Berhasil",
                  btnOkOnPress: () {
                    context.pop();
                  },
                  btnOkIcon: Icons.check_circle,
                  onDismissCallback: (type) {
                    debugPrint('Dialog Dissmiss from callback $type');
                  },
                ).show();
                ref.read(getUserProvider);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.wallet_rounded),
              SizedBox(
                width: 10,
              ),
              Text("Top Up")
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Top Up",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 22),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFf4C10F)),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Enter Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                CurrencyFormat.convertToIdr(_value, 0),
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SfSlider(
              stepSize: 50000,
              min: 0.0,
              max: 1000000.0,
              value: _value,
              interval: 100000,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                  topUped = _value;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 200,
              child: GridView.count(
                childAspectRatio: 1.5,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 3,
                children: List.generate(6, (index) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selected = index;
                        _value = instant[index];
                        topUped = _value;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: index == selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(instant[index], 0),
                            style: TextStyle(
                                color: index == selected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
