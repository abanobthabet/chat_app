import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login({
    required String email,
    required String password,
  })async {
      emit(LoginLoding());
    try {

    FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential =await  auth. signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
