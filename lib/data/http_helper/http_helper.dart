import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_movies_app/data/entities/category_model.dart';
import 'package:flutter_movies_app/data/entities/error_model.dart';
import 'package:flutter_movies_app/data/entities/movie_model.dart';
import 'package:flutter_movies_app/data/entities/pagination_model.dart';
import 'package:flutter_movies_app/data/entities/user_model.dart';
import 'package:flutter_movies_app/utils/constant.dart';

class HttpHelper {
  final Dio dio;

  HttpHelper(this.dio) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    dio.options.connectTimeout = const Duration(seconds: 90);
    dio.options.headers.addAll({"Authorization": "Bearer $API_KEY"});
  }

  Future<Either<ErrorModel, String>> createRequestToken() async {
    try {
      Response response =
          await dio.get("$API_BASE_URL/authentication/token/new");
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(jsonDecode(response.toString())['request_token']);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, String>> createSession(String requestToken) async {
    try {
      Map<String, dynamic> body = {
        "request_token": requestToken,
      };
      Response response = await dio.post(
        "$API_BASE_URL/authentication/session/new",
        data: body,
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(jsonDecode(response.toString())['session_id']);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, UserModel>> getUserDetails(String sessionId) async {
    try {
      Map<String, dynamic> params = {"session_id": sessionId};
      Response response = await dio.get(
        "$API_BASE_URL/account/null",
        queryParameters: params,
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(UserModel.fromJson(jsonDecode(response.toString())));
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, List<CategoryModel>>> getCategories() async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/genre/movie/list?language=en",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      List<CategoryModel> categories = [];
      for (int i = 0;
          i < jsonDecode(response.toString())['genres'].length;
          i++) {
        categories.add(CategoryModel.fromJson(
            jsonDecode(response.toString())['genres'][i]));
      }
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, List<MovieModel>>> getUpcomingMovies() async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/movie/upcoming?language=en-US&page=1",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      List<MovieModel> movies = [];
      for (int i = 0;
          i < jsonDecode(response.toString())['results'].length;
          i++) {
        movies.add(
            MovieModel.fromJson(jsonDecode(response.toString())['results'][i]));
      }
      return Right(movies);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, List<MovieModel>>> getTrendingMovies() async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/movie/popular?language=en-US&page=1",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      List<MovieModel> movies = [];
      for (int i = 0;
          i < jsonDecode(response.toString())['results'].length;
          i++) {
        movies.add(
            MovieModel.fromJson(jsonDecode(response.toString())['results'][i]));
      }
      return Right(movies);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, MovieModel>> getMovieDetails(int id) async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/movie/$id?language=en-US",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(MovieModel.fromJson(jsonDecode(response.toString())));
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, String>> toggleToFav(
      int id, String sessionId, bool addToFav) async {
    try {
      Map<String, dynamic> body = {
        "media_type": "movie",
        "media_id": id,
        "favorite": addToFav
      };
      Response response = await dio.post(
        "$API_BASE_URL/account/null/favorite?session_id=$sessionId",
        data: body,
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(jsonDecode(response.toString())['status_message']);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, List<MovieModel>>> getFavoriteMovies(
      String sessionId) async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/account/null/favorite/movies?language=en-US&page=1&sort_by=created_at.asc",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      List<MovieModel> movies = [];
      for (int i = 0;
          i < jsonDecode(response.toString())['results'].length;
          i++) {
        movies.add(
            MovieModel.fromJson(jsonDecode(response.toString())['results'][i]));
      }
      return Right(movies);
    } catch (e) {
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }

  Future<Either<ErrorModel, PaginationModel>> searchMovies(
      String query, int pageNum) async {
    try {
      Response response = await dio.get(
        "$API_BASE_URL/search/movie?query=$query&include_adult=true&language=en-US&page=$pageNum",
      );
      if (jsonDecode(response.toString())['success'] == false) {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString())));
      }
      return Right(PaginationModel.fromJson(jsonDecode(response.toString())));
    } catch (e) {
      print("fucky $e");
      if (e is DioException) {
        return Left(ErrorModel.fromJson(jsonDecode(e.response.toString())));
      }
      return Left(ErrorModel.baseError(e.toString()));
    }
  }
}
