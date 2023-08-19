import 'package:either_dart/either.dart';
import 'package:flutter_movies_app/data/entities/category_model.dart';
import 'package:flutter_movies_app/data/entities/error_model.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/entities/pagination_model.dart';
import 'package:flutter_movies_app/data/entities/user_model.dart';
import 'package:flutter_movies_app/data/http_helper/http_helper.dart';
import 'package:flutter_movies_app/data/perfs_helper/prefs_helper.dart';
import 'package:flutter_movies_app/utils/constant.dart';

class Repository {
  final HttpHelper _httpHelper;
  final PrefsHelper _prefsHelper;

  Repository(this._httpHelper, this._prefsHelper);

  String get requestToken => _prefsHelper.requestToken;

  String get sessionId => _prefsHelper.sessionId;

  String get userDetails => _prefsHelper.userDetails;

  saveRequestToken(String requestToken) async =>
      await _prefsHelper.saveRequestToken(requestToken);

  saveSessionId(String sessionId) async =>
      await _prefsHelper.saveSessionId(sessionId);

  saveUserDetails(UserModel user) async =>
      await _prefsHelper.saveUserDetails(user);

  Future<Either<ErrorModel, String>> createRequestToken() async =>
      await _httpHelper.createRequestToken();

  Future<Either<ErrorModel, String>> createSession(String requestToken) async =>
      await _httpHelper.createSession(requestToken);

  Future<Either<ErrorModel, UserModel>> getUserDetails(
          String sessionId) async =>
      await _httpHelper.getUserDetails(sessionId);

  Future<Either<ErrorModel, List<CategoryModel>>> getCategories() async =>
      await _httpHelper.getCategories();

  Future<Either<ErrorModel, List<MovieModel>>> getUpcomingMovies() async =>
      await _httpHelper.getUpcomingMovies();

  Future<Either<ErrorModel, List<MovieModel>>> getTrendingMovies() async =>
      await _httpHelper.getTrendingMovies();

  Future<Either<ErrorModel, MovieModel>> getMovieDetails(int id) async =>
      await _httpHelper.getMovieDetails(id);

  Future<Either<ErrorModel, String>> toggleToFav(
          int id, String sessionId, bool addToFav) async =>
      await _httpHelper.toggleToFav(id, sessionId, addToFav);

  Future<Either<ErrorModel, List<MovieModel>>> getFavoriteMovies(
          String sessionId) async =>
      await _httpHelper.getFavoriteMovies(sessionId);

  Future<Either<ErrorModel, PaginationModel>> searchMovies(
          String query, int pageNum) async =>
      await _httpHelper.searchMovies(query, pageNum);
}
