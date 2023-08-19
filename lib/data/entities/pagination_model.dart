import 'package:flutter_movies_app/data/entities/movie_model.dart';

class PaginationModel {
  final int page;
  final List<MovieModel> movies;
  final int totalPages;
  final int totalResults;

  PaginationModel({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    List<MovieModel> movies = [];
    for (int i = 0; i < json['results'].length; i++) {
      movies.add(MovieModel.fromJson(json['results'][i]));
    }
    return PaginationModel(
      page: json['page'],
      movies: movies,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
