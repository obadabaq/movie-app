import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/entities/category_model.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/entities/user_model.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_event.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository _repository;

  UserModel? userModel;

  bool loadingCategories = true;
  List<CategoryModel> categories = [];

  bool loadingUpcomingMovies = true;
  List<MovieModel> upcomingMovies = [];

  bool loadingTrendingMovies = true;
  List<MovieModel> trendingMovies = [];

  HomeBloc(this._repository) : super(Initial()) {
    on<InitHome>((event, emit) async {
      loadingCategories = true;
      loadingUpcomingMovies = true;
      loadingTrendingMovies = true;
      
      userModel = UserModel.fromJson(jsonDecode(_repository.userDetails));
      emit(GotUserSuccessfully());

      var categoriesResponse = await _repository.getCategories();
      loadingCategories = false;
      if (categoriesResponse.isRight) categories = categoriesResponse.right;
      emit(GotCategoriesSuccessfully());

      var upcomingTrendingResponse = await _repository.getTrendingMovies();
      loadingTrendingMovies = false;
      if (upcomingTrendingResponse.isRight)
        trendingMovies = upcomingTrendingResponse.right;
      emit(GotUpcomingMoviesSuccessfully());

      var upcomingMoviesResponse = await _repository.getUpcomingMovies();
      loadingUpcomingMovies = false;
      if (upcomingMoviesResponse.isRight)
        upcomingMovies = upcomingMoviesResponse.right;
      emit(GotUpcomingMoviesSuccessfully());
    });
  }
}
