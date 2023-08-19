import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/entities/error_model.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/entities/pagination_model.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_event.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final Repository _repository;

  List<MovieModel> movies = [];
  int totalPages = 0;
  int pageNum = 1;

  TextEditingController searchCont = TextEditingController();

  ErrorModel? errorModel;

  // ScrollController scrollController = ScrollController();

  ExploreBloc(this._repository) : super(Initial()) {
    on<InitExplore>((event, emit) async {});

    on<ChangedSearch>((event, emit) async {
      totalPages = 0;
      pageNum = 1;
      emit(LoadingSearch());
      searchCont.text = event.query;
      Either<ErrorModel, PaginationModel> response =
          await _repository.searchMovies(searchCont.text, pageNum);
      if (response.isLeft) {
        errorModel = response.left;
        emit(ErrorSearch(errorModel!));
      } else {
        totalPages = response.right.totalPages;
        movies = response.right.movies;
        pageNum = response.right.page + 1;
        emit(GotNewMovies());
      }
    });

    on<ScrollMore>((event, emit) async {
      emit(LoadingMore());
      Either<ErrorModel, PaginationModel> response =
      await _repository.searchMovies(searchCont.text, pageNum);
      if (response.isLeft) {
        errorModel = response.left;
        emit(ErrorSearch(errorModel!));
      } else {
        totalPages = response.right.totalPages;
        movies.addAll(response.right.movies);
        pageNum = response.right.page + 1;
        emit(GotNewMovies());
      }
    });
  }
}
