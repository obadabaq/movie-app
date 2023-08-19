import 'package:dio/dio.dart';
import 'package:flutter_movies_app/data/http_helper/http_helper.dart';
import 'package:flutter_movies_app/data/perfs_helper/prefs_helper.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_bloc.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_bloc.dart';
import 'package:flutter_movies_app/presentation/movie/bloc/movie_bloc.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initApp() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  final client = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 90),
      baseUrl: API_BASE_URL,
      responseType: ResponseType.plain,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
    ),
  );

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => client);
  sl.registerLazySingleton(() => HttpHelper(sl()));
  sl.registerLazySingleton(() => PrefsHelper(sl()));
  sl.registerLazySingleton(() => Repository(sl(), sl()));

  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => MovieBloc(sl()));
  sl.registerFactory(() => FavoriteBloc(sl()));
  sl.registerFactory(() => ExploreBloc(sl()));
}
