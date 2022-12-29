import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../service/provider.dart';
import '../service/transaction_provider.dart';
import '../widget/transaction_widget.dart';
import '../widget/user_widget.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    // riverpod
    final data = ref.watch(transactionStreamProvider);
    final dataUser = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "User",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: dataUser!['profile'] != null
                              ? NetworkImage(dataUser['profile'])
                              : const AssetImage('./assets/images/img_null.png')
                                  as ImageProvider),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.primary),
                    child: IconButton(
                      onPressed: () {
                        context.pushNamed('userEdit');
                      },
                      color: Colors.black,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              dataUser['username'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              dataUser['email'],
              style: const TextStyle(fontSize: 16, color: Colors.white60),
            ),
            const SizedBox(height: 10),
            const Divider(),

            // saldo

            const SizedBox(height: 10),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.wallet,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      CurrencyFormat.convertToIdr(
                          int.tryParse(dataUser['wallet']) ?? 0, 2),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100))),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          context.pushNamed('topUp');
                        },
                        icon: Icon(
                          Icons.add,
                          size: 25,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // history
            const SizedBox(height: 10),
            const Divider(),
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ]),
        )
      ]),
    );
  }
}
