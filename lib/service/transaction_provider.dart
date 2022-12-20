import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_2072046/entity/transactions/transaction.dart';
import 'package:movie_app_2072046/service/provider.dart';

final transactionStreamProvider = StreamProvider(
  (ref) {
    final user = ref.watch(userNow);

    final transactions = FirebaseFirestore.instance
        .collection('transactions')
        .where('uid', isEqualTo: user!.uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Transaksi.fromJson(doc.data()))
            .toList());
    return transactions;
  },
);
