import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_event.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/helpers/helpers.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:flutter_movies_app/utils/route_generator.dart';
import 'package:jumping_dot/jumping_dot.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final bloc = sl<SplashBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.add(InitSplash());
    return BlocListener(
      bloc: bloc,
      listener: (_, state) {
        if (state is GetPermission) {
          Navigator.pushNamed(
            context,
            RouteNames.WEB_VIEW_SCREEN,
            arguments: {
              "url": "$AUTHENTICATE_URL${state.url}",
              "splashBloc": bloc,
            },
          );
        }
        if (state is SessionCreatedSuccessfully) {
          bloc.add(GotSessionId());
        }
        if (state is SplashDoneSuccessfully || state is UserLoggedIn) {
          Navigator.pushReplacementNamed(context, RouteNames.MAIN_SCREEN);
        }
        if (state is ErrorSplash) {
          Helpers.showErrorDialog(
            context,
            errorMsg: state.error.statusMsg,
            onConfirm: () {
              Navigator.pop(context);
              bloc.add(InitSplash());
            },
            onCancel: () {
              exit(0);
            },
          );
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          return Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            body: Center(
              child: JumpingDots(
                color: PRIMARY_COLOR,
                radius: 10,
                numberOfDots: 3,
              ),
            ),
          );
        },
      ),
    );
  }
}
