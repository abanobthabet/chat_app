import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on((event, state) async {
      if (event is LoginUserEvent) {
        emit(LoginLoding());
        try {
          FirebaseAuth auth = FirebaseAuth.instance;

          UserCredential userCredential = await auth
              .signInWithEmailAndPassword(
                email: event.email,
                password: event.password,
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
    });
  }
}
