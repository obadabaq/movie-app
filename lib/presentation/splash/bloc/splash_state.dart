import 'package:flutter_movies_app/data/entities/error_model.dart';

abstract class SplashState {}

class Initial extends SplashState {}

class UserLoggedIn extends SplashState {}

class GetPermission extends SplashState {
  final String url;

  GetPermission(this.url);
}

class UserResponseDone extends SplashState {}

class SessionCreatedSuccessfully extends SplashState {}

class SplashDoneSuccessfully extends SplashState {}

class ErrorSplash extends SplashState {
  final ErrorModel error;

  ErrorSplash(this.error);
}
