import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../repository/notif.dart';

class SignUp extends StatefulWidget {
  final String title;
  const SignUp({Key? key, required this.title}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  // firebase
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConfirmation =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                height: 60,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        height: 20,
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
                        height: 20,
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
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _controllerEmail.text,
                                      password: _controllerPassword.text);

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
