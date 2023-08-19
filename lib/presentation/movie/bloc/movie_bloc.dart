import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/entities/error_model.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/movie/bloc/movie_event.dart';
import 'package:flutter_movies_app/presentation/movie/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final Repository _repository;

  bool loadingMovie = true;
  MovieModel? movie;
  bool isLiked = false;

  ErrorModel? errorModel;

  MovieBloc(this._repository) : super(Initial()) {
    on<InitMovie>((event, emit) async {
      isLiked = false;
      Either<ErrorModel, MovieModel> response =
          await _repository.getMovieDetails(event.id);
      if (response.isLeft) {
        errorModel = response.left;
        emit(ErrorGettingMovie());
      } else {
        loadingMovie = false;
        movie = response.right;
        emit(SuccessfullyGettingMovie());
      }
    });

    on<PressLike>((event, emit) async {
      isLiked = !isLiked;
      String sessionId = _repository.sessionId;
      _repository.toggleToFav(movie!.id, sessionId, isLiked);
      emit(LikeToggled());
    });
  }
}
