abstract class MovieState {}

class Initial extends MovieState {}

class SuccessfullyGettingMovie extends MovieState {}

class ErrorGettingMovie extends MovieState {}

class LikeToggled extends MovieState {}
