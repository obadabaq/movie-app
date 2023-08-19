abstract class MovieEvent {}

class InitMovie extends MovieEvent {
  final int id;

  InitMovie(this.id);
}

class PressLike extends MovieEvent {}
