import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/data/entities/error_model.dart';
import 'package:flutter_movies_app/data/entities/user_model.dart';
import 'package:flutter_movies_app/data/repository/repository.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_event.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final Repository _repository;

  SplashBloc(this._repository) : super(Initial()) {
    on<InitSplash>((event, emit) async {
      if (_repository.userDetails.isNotEmpty) {
        emit(UserLoggedIn());
      } else {
        Either<ErrorModel, String> response =
            await _repository.createRequestToken();
        if (response.isLeft) {
          emit(ErrorSplash(response.left));
        } else {
          await _repository.saveRequestToken(response.right);
          emit(GetPermission(response.right));
        }
      }
    });

    on<GotPermission>((event, emit) async {
      String requestToken = _repository.requestToken;
      Either<ErrorModel, String> response =
          await _repository.createSession(requestToken);
      if (response.isLeft) {
        emit(ErrorSplash(response.left));
      } else {
        await _repository.saveSessionId(response.right);
        emit(SessionCreatedSuccessfully());
      }
    });

    on<GotSessionId>((event, emit) async {
      String sessionId = _repository.sessionId;
      Either<ErrorModel, UserModel> response =
          await _repository.getUserDetails(sessionId);
      if (response.isLeft) {
        emit(ErrorSplash(response.left));
      } else {
        await _repository.saveUserDetails(response.right);
        emit(SplashDoneSuccessfully());
      }
    });
  }
}
