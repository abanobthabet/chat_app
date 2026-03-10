import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_login.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String? email, password;

  GlobalKey<FormState> primrykey = GlobalKey();
  AutovalidateMode? autovalidateMode =
      AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMassege();
          Navigator.pushNamed(context, ChatScreen.id);
        } else if (state is LoginFailure) {
          show_massege(context, massege: state.errmassege);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoding ? true : false,
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
                          BlocProvider.of<LoginCubit>(
                            context,
                          ).login(
                            email: email!,
                            password: password!,
                          );
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
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
      },
    );
  }
}
