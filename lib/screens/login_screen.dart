import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_login.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  GlobalKey<FormState> primrykey = GlobalKey();
  AutovalidateMode? autovalidateMode =
      AutovalidateMode.disabled;
  bool isloding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloding,
      child: Scaffold(
        backgroundColor: kPraimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Form(
            autovalidateMode: autovalidateMode,
            key: primrykey,
            child: ListView(
              children: [
                SizedBox(height: 90),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 90),
                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomTextField(
                  hinttext: 'Email',
                  iconsData: Icons.email,
                  onchange: (date) {
                    email = date;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  hinttext: 'password',
                  iconsData: Icons.password_sharp,
                  onchange: (date) {
                    password = date;
                  },
                ),
                SizedBox(height: 20),
                CustomLogin(
                  text: 'Login',
                  ontap: () async {
                    if (primrykey.currentState!
                        .validate()) {
                      isloding = true;
                      setState(() {});
                      try {
                        await login_email_password();
                        Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (
                        ex
                      ) {
                        print(ex);
                        if (ex.code == 'user-not-found') {
                          show_massege(
                            context,
                            massege:
                                'No user found for that email.',
                          );
                        } else if (ex.code ==
                            'wrong-password') {
                          show_massege(
                            context,
                            massege:
                                'Wrong password provided for that user.',
                          );
                        } else if (ex.code ==
                            'invalid-credential') {
                          show_massege(
                            context,
                            massege:
                                'Invalid credentials. Please check your email and password.',
                          );
                        }
                      } catch (ex) {
                        show_massege(
                          context,
                          massege: 'error',
                        );
                      }
                      isloding = false;
                      setState(() {});
                    } else {
                      autovalidateMode =
                          AutovalidateMode.always;
                    }
                  },
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an accont ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RegisterScreen.id,
                        );
                      },
                      child: Text(
                        '   Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login_email_password() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth
        .signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
  }
}
