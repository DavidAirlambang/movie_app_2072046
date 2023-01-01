import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../service/provider.dart';
import '../../widget/notif.dart';

class SignUp extends ConsumerStatefulWidget {
  final String title;
  const SignUp({Key? key, required this.title}) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  void pickUpLoadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 215,
        maxHeight: 215,
        imageQuality: 20);

    Reference storage = FirebaseStorage.instance.ref().child('profile.jpg');

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
        ref.read(profileImageProvider.notifier).state = value;
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  DateTime? selectedDate;

  // firebase
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConfirmation =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //riverpod
    final profile = ref.watch(profileImageProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: profile != " "
                                ? NetworkImage(profile)
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
                          color: Theme.of(context).colorScheme.primary),
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
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
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
                        controller: _controllerEmail,
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Masukan email anda",
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Masukan email anda',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: _controllerPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukan password anda';
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Masukan password anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _controllerPasswordConfirmation,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value != _controllerPassword.text) {
                            return 'Password tidak sesuai';
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Konfirmasi password anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                        child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    )));

                            try {
                              // create
                              UserCredential result = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: _controllerEmail.text,
                                      password: _controllerPassword.text);

                              User? user = result.user;
                              ref.read(userNow.notifier).state = user;

                              // add user
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .set({
                                'username': _controllerUsername.text,
                                'email': _controllerEmail.text,
                                'address': _controllerAddress.text,
                                'birth': selectedDate,
                                'profile': profile,
                                'wallet': "0",
                                'uid': user.uid,
                              });

                              Navigator.of(context, rootNavigator: true).pop();

                              context.goNamed("main");
                            } on FirebaseAuthException catch (e) {
                              Navigator.of(context, rootNavigator: true).pop();

                              Notif.showSnackBar(e.message);
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah punya akun?',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () async {
                              context.goNamed('signIn');
                            },
                            child: const Text('Sign In disini'),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
