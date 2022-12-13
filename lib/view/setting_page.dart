import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_2072046/service/provider.dart';
import 'package:movie_app_2072046/widget/user_widget.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataUser = ref.watch(userProvider);
    final usernya = ref.watch(userNow);

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _controllerUsername = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();

    Color bacColor = Theme.of(context).colorScheme.background;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SettingsList(
        darkTheme: SettingsThemeData(settingsListBackground: bacColor),
        sections: [
          const CustomSettingsSection(child: Center(child: UserWidget())),
          SettingsSection(
            title: const Text("Setting"),
            tiles: [
              SettingsTile.navigation(
                onPressed: (context) {
                  late AwesomeDialog dialog;
                  dialog = AwesomeDialog(
                    dialogBackgroundColor: Colors.grey[800],
                    context: context,
                    dialogType: DialogType.noHeader,
                    keyboardAware: true,
                    body: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Ganti Username',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 0,
                            color: Colors.grey[800],
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                autofocus: true,
                                controller: _controllerUsername,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukan username baru anda';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Masukan username baru anda',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedButton(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            isFixedHeight: false,
                            text: 'Save',
                            pressEvent: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                          )
                        ],
                      ),
                    ),
                  )..show();
                },
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                leading: const Icon(Icons.person, size: 30),
                title: const Text('Change Username',
                    style: TextStyle(fontSize: 16)),
              ),
              SettingsTile.navigation(
                onPressed: (context) {
                  late AwesomeDialog dialog;
                  dialog = AwesomeDialog(
                    dialogBackgroundColor: Colors.grey[800],
                    context: context,
                    dialogType: DialogType.noHeader,
                    keyboardAware: true,
                    body: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Ganti Password',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 0,
                            color: Colors.grey[800],
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                autofocus: true,
                                controller: _controllerUsername,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukan password baru anda';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Masukan password baru anda',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedButton(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            isFixedHeight: false,
                            text: 'Save',
                            pressEvent: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                          )
                        ],
                      ),
                    ),
                  )..show();
                },
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                leading: const Icon(Icons.password, size: 30),
                title: const Text('Change Password',
                    style: TextStyle(fontSize: 16)),
              ),
              SettingsTile.navigation(
                onPressed: (context) {
                  context.goNamed('signIn');
                  FirebaseAuth.instance.signOut();
                },
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                leading: const Icon(Icons.logout_rounded, size: 30),
                title: const Text('Sign Out', style: TextStyle(fontSize: 16)),
              ),

              // batas
            ],
          ),
        ],
      ),
    );
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
