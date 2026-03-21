part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoding extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {
  String errmassege;
  LoginFailure(this.errmassege);
}

