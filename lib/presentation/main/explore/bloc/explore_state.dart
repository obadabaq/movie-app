import 'package:flutter_movies_app/data/entities/error_model.dart';

abstract class ExploreState {}

class Initial extends ExploreState {}

class LoadingSearch extends ExploreState {}

class GotNewMovies extends ExploreState {}

class ErrorSearch extends ExploreState {
  final ErrorModel errorModel;

  ErrorSearch(this.errorModel);
}

class LoadingMore extends ExploreState {}
