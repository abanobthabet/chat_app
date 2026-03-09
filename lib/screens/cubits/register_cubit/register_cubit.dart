import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registeruser({
   required String email,
   required String password,
  }) async {
    emit(RegisterLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(
          RegisterFailure(
            errmassege:
                'The password provided is too weak.',
          ),
        );
      } else if (ex.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
            errmassege:
                'The account already exists for that email.',
          ),
        );
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errmassege: 'error'));
    }
  }
}
