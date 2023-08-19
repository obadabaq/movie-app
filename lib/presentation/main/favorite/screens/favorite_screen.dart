import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_event.dart';
import 'package:flutter_movies_app/presentation/main/favorite/bloc/favorite_state.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  final bloc = sl<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.add(InitFavorite());
    return BlocBuilder(
      bloc: bloc,
      builder: (_, state) {
        if (state is! LoadingFav) {
          return RefreshIndicator(
            onRefresh: () {
              bloc.add(InitFavorite());
              return Future.value(true);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: ListView.builder(
                itemCount: bloc.favoriteMovies.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Container(
                    width: double.infinity,
                    height: 120.sp,
                    margin: EdgeInsets.symmetric(vertical: 10.sp),
                    padding: EdgeInsets.symmetric(
                        vertical: 15.sp, horizontal: 15.sp),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PRIMARY_COLOR,
                        width: 1.sp,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 90.sp,
                          width: 55.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              "$IMAGE_BASE_URL${bloc.favoriteMovies[index].poster}",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Shimmer.fromColors(
                                  baseColor: OFF_BACKGROUND_COLOR,
                                  highlightColor: OFF_PRIMARY_COLOR,
                                  child: Container(
                                    height: 90.sp,
                                    width: 55.sp,
                                    decoration: BoxDecoration(
                                      color: OFF_BACKGROUND_COLOR,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120.sp,
                              height: 20.sp,
                              child: Text(
                                bloc.favoriteMovies[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: PRIMARY_COLOR,
                                        overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(
                              width: 120.sp,
                              height: 60.sp,
                              child: Text(
                                bloc.favoriteMovies[index].overview!,
                                maxLines: 8,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: WHITE_COLOR,
                                        overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        IconButton(
                          onPressed: () {
                            bloc.add(RemoveMovieFromFav(
                                bloc.favoriteMovies[index].id));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: WHITE_COLOR,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () {
              bloc.add(InitFavorite());
              return Future.value(true);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: const Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
