import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_login.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isloding = false;

  GlobalKey<FormState> formkey = GlobalKey();

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
            key: formkey,
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
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomTextField(
                  onchange: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                  iconsData: Icons.email,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  onchange: (data) {
                    password = data;
                  },
                  hinttext: 'password',
                  iconsData: Icons.password_sharp,
                ),
                SizedBox(height: 20),
                CustomLogin(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isloding = true;
                      setState(() {});
                      try {
                        await registeruser();
                         Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          show_massege(
                            context,
                            massege: 'The password provided is too weak.',
                          );
                        } else if (e.code ==
                            'email-already-in-use') {
                          show_massege(
                            context,
                           massege: 'The account already exists for that email.',
                          );
                        }
                      } catch (e) {
                        show_massege(context,massege:  'error');
                      }
                      isloding = false;
                      setState(() {});
                    }
                  },
                  text: 'Register',
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an accont ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '   login',
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

  void showmassege(BuildContext context, String massege) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(massege)));
  }

  Future<void> registeruser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
     UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
  }
}
