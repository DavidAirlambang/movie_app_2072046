import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_2072046/service/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widget/notif.dart';

class UserEdit extends ConsumerStatefulWidget {
  const UserEdit({super.key});

  @override
  ConsumerState<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends ConsumerState<UserEdit> {
  // untuk edit
  var editable = false;
  DateTime? selectedDate;

  // untuk form
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
// profile picture
    void pickUpLoadImage() async {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 215,
          maxHeight: 215,
          imageQuality: 20);

      Reference storage =
          FirebaseStorage.instance.ref().child('${ref.read(userNow)!.uid}.jpg');

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )));

      await storage.putFile(File(image!.path));
      storage.getDownloadURL().then((value) {
        setState(() {
          ref.read(updateUserProvider({'profile': value}));
          ref.read(getUserProvider);
          Navigator.of(context, rootNavigator: true).pop();
        });
      });
    }

    //riverpod
    final dataUser = ref.watch(userProvider);

    _controllerUsername.text = dataUser!['username'];
    _controllerAddress.text = dataUser['address'];
    _controllerDate.text = editable
        ? _controllerDate.text
        : DateFormat('dd MMMM yyyy')
            .format((dataUser['birth']).toDate())
            .toString();

    // color
    Color bacColor = Theme.of(context).colorScheme.background;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFf4C10F)),
        title: const Text(
          "Profile Setting",
          style: TextStyle(color: Color(0xFFf4C10F), fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SettingsList(
        darkTheme: SettingsThemeData(settingsListBackground: bacColor),
        sections: [
          SettingsSection(
            tiles: [
              CustomSettingsTile(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: dataUser['profile'] != null
                                          ? NetworkImage(
                                              dataUser['profile'].toString())
                                          : const AssetImage(
                                                  './assets/images/img_null.png')
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: IconButton(
                                  onPressed: () {
                                    pickUpLoadImage();
                                  },
                                  color: Colors.black,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          dataUser['username'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Divider()),
                      ],
                    ),
                  ),
                ),
              ),
              CustomSettingsTile(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: editable ? true : false,
                          controller: _controllerUsername,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukan username anda';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'Masukan Username anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          enabled: editable ? true : false,
                          controller: _controllerAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukan address anda';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.home_rounded),
                            hintText: 'Masukan Address anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          enabled: editable ? true : false,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMMM yyyy').format(pickedDate);

                              setState(() {
                                _controllerDate.text = formattedDate;
                                selectedDate = pickedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          controller: _controllerDate,
                          cursorColor: Colors.transparent,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukan date of birth anda';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Masukan date of birth anda',
                            prefixIcon: const Icon(Icons.date_range_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed:

                                //edit enable
                                editable
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) => Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  )));

                                          if (selectedDate == null) {
                                            selectedDate =
                                                (dataUser['birth']).toDate();
                                          } else {}

                                          try {
                                            // update username
                                            ref.read(updateUserProvider({
                                              'username':
                                                  _controllerUsername.text
                                            }));
                                            ref.read(getUserProvider);

                                            // update address
                                            ref.read(updateUserProvider({
                                              'address': _controllerAddress.text
                                            }));
                                            ref.read(getUserProvider);

                                            // update date of birth
                                            ref.read(updateUserProvider(
                                                {'birth': selectedDate}));
                                            ref.read(getUserProvider);

                                            await Future.delayed(
                                                    const Duration(seconds: 2))
                                                .then((value) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              setState(() {
                                                editable = false;
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              });
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();

                                            Notif.showSnackBar(e.message);
                                          }
                                        }
                                      }
                                    // edit disable
                                    : () {
                                        setState(() {
                                          editable = true;
                                          FocusScope.of(context).unfocus();
                                        });
                                      },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 15, 40, 15),
                            ),
                            child: Text(
                              editable ? 'Save' : 'Edit',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(thickness: 1),
                      ],
                    )),
              )),

              SettingsTile.navigation(
                onPressed: (context) {
                  context.goNamed('signIn');
                  FirebaseAuth.instance.signOut();
                },
                leading: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: Colors.red,
                ),
                title: const Text('Sign Out',
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              ),

              // batas
            ],
          ),
        ],
      ),
    );
  }
}
