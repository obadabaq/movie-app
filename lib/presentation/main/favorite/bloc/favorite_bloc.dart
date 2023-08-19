import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_event.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Repository _repository;

  List<MovieModel> favoriteMovies = [];

  FavoriteBloc(this._repository) : super(Initial()) {
    on<InitFavorite>((event, emit) async {
      emit(LoadingFav());

      String sessionId = _repository.sessionId;
      var favoriteMoviesResponse =
          await _repository.getFavoriteMovies(sessionId);
      if (favoriteMoviesResponse.isRight) {
        favoriteMovies = favoriteMoviesResponse.right;
      }
      emit(GotFavoriteMoviesSuccessfully());
    });

    on<RemoveMovieFromFav>((event, emit) async {
      emit(LoadingFav());
      String sessionId = _repository.sessionId;
      await _repository.toggleToFav(event.id, sessionId, false);

      var favoriteMoviesResponse =
          await _repository.getFavoriteMovies(sessionId);
      if (favoriteMoviesResponse.isRight) {
        favoriteMovies = favoriteMoviesResponse.right;
      }
      emit(GotFavoriteMoviesSuccessfully());
    });
  }
}
