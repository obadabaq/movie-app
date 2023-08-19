abstract class SplashEvent {}

class InitSplash extends SplashEvent {}

class GotPermission extends SplashEvent {
  final bool isGranted;

  GotPermission(this.isGranted);
}

class GotSessionId extends SplashEvent {}
