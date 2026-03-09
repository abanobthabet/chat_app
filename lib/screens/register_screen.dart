import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/widgets/custom_login.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'RegisterScreen';
  String? email;

  String? password;

  bool isloding = false;

  GlobalKey<FormState> formkey = GlobalKey();
  AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
        } else if (state is RegisterFailure) {
          show_massege(context, massege: state.errmassege);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading
              ? true
              : false,
          child: Scaffold(
            backgroundColor: kPraimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Form(
                autovalidateMode: autovalidateMode,
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
                        if (formkey.currentState!
                            .validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).registeruser(
                            email: email!,
                            password: password!,
                          );
                        } else {
                          autovalidateMode =
                              AutovalidateMode.always;
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
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
      },
    );
  }

  void showmassege(BuildContext context, String massege) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(massege)));
  }
}
