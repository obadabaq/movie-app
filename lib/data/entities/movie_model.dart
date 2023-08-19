class MovieModel {
  final List<int> categoriesIds;
  final List<Map<String, dynamic>>? categories;
  final int id;
  final String title;
  final double rating;
  final num? avgRating;
  final int? runTime;
  final String? releaseDate;
  final String? overview;
  final String poster;
  final bool adult;

  MovieModel({
    required this.categoriesIds,
    this.categories,
    required this.id,
    required this.title,
    required this.rating,
    this.avgRating,
    this.runTime,
    this.releaseDate,
    this.overview,
    required this.poster,
    required this.adult,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    List<int> tmp = [];
    if (json['genre_ids'] != null) {
      for (int i = 0; i < json['genre_ids'].length; i++) {
        tmp.add(json['genre_ids'][i]);
      }
    }
    List<Map<String, dynamic>> tmpCategories = [];
    if (json['genres'] != null) {
      for (int i = 0; i < json['genres'].length; i++) {
        tmpCategories.add(json['genres'][i]);
      }
    }
    return MovieModel(
      categoriesIds: tmp,
      categories: tmpCategories,
      id: json['id'],
      title: json['title'],
      rating: json['popularity'],
      poster: json['poster_path'] ?? "",
      adult: json['adult'],
      avgRating: json['vote_average'],
      runTime: json['runtime'],
      releaseDate: json['release_date'],
      overview: json['overview'],
    );
  }
}
