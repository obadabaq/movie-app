abstract class FavoriteEvent {}

class InitFavorite extends FavoriteEvent {}

class RemoveMovieFromFav extends FavoriteEvent {
  final int id;

  RemoveMovieFromFav(this.id);
}