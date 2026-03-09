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
  }) async {
    emit(LoginLoding());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure('user-not-found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure('wrong-password'));
      } else if (ex.code == 'invalid-credential') {
        emit(
          LoginFailure(
            'Invalid credentials. Please check your email and password',
          ),
        );
      }
    } catch (e) {
      emit(LoginFailure('error'));
    }
  }
}
