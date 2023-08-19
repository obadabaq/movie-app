import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/presentation/movie/bloc/movie_bloc.dart';
import 'package:flutter_movies_app/presentation/movie/bloc/movie_event.dart';
import 'package:flutter_movies_app/presentation/movie/widgets/details_card.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieScreen extends StatelessWidget {
  final int movieId;

  MovieScreen({Key? key, required this.movieId}) : super(key: key);

  final bloc = sl<MovieBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.add(InitMovie(movieId));
    return BlocBuilder(
      bloc: bloc,
      builder: (_, state) {
        if (!bloc.loadingMovie) {
          return Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: BACKGROUND_COLOR,
              toolbarHeight: 80.sp,
              title: Text(
                "Movie Details",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: WHITE_COLOR),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: WHITE_COLOR,
                  size: 14.sp,
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 275.sp,
                              width: 185.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  "$IMAGE_BASE_URL${bloc.movie!.poster}",
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: OFF_BACKGROUND_COLOR,
                                      highlightColor: OFF_PRIMARY_COLOR,
                                      child: Container(
                                        height: 275.sp,
                                        width: 185.sp,
                                        decoration: BoxDecoration(
                                          color: OFF_BACKGROUND_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  bloc.isLiked == false
                                      ? Icons.bookmark_add_outlined
                                      : Icons.bookmark,
                                  color: bloc.isLiked == false
                                      ? PRIMARY_COLOR
                                      : PRIMARY_COLOR,
                                  size: 35.sp,
                                ),
                                onPressed: () {
                                  bloc.add(PressLike());
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 275.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailsCard(
                                  icon: const Icon(
                                    Icons.category,
                                    color: WHITE_COLOR,
                                  ),
                                  title: "Genre",
                                  content:
                                      "${bloc.movie!.categories![0]['name']}\n${bloc.movie!.categories![1]['name']}"),
                              DetailsCard(
                                  icon: const Icon(
                                    Icons.timer,
                                    color: WHITE_COLOR,
                                  ),
                                  title: "Duration",
                                  content: "${bloc.movie!.runTime} mins"),
                              DetailsCard(
                                  icon: const Icon(
                                    Icons.star_rate,
                                    color: WHITE_COLOR,
                                  ),
                                  title: "Rating",
                                  content: "${bloc.movie!.avgRating}"),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      bloc.movie!.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: WHITE_COLOR,
                          ),
                    ),
                    Text(
                      "${bloc.movie!.releaseDate}",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: WHITE_COLOR.withOpacity(0.5),
                          ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      "Plot Summary",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: OFF_BACKGROUND_COLOR,
                          ),
                    ),
                    Text(
                      bloc.movie!.overview!,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: WHITE_COLOR,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: BACKGROUND_COLOR,
              toolbarHeight: 80.sp,
              title: Text(
                "Movie Details",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: WHITE_COLOR),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: WHITE_COLOR,
                  size: 14.sp,
                ),
              ),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: OFF_BACKGROUND_COLOR,
                          highlightColor: OFF_PRIMARY_COLOR,
                          child: Container(
                            height: 275.sp,
                            width: 185.sp,
                            decoration: BoxDecoration(
                              color: OFF_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 275.sp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: OFF_BACKGROUND_COLOR,
                                highlightColor: OFF_PRIMARY_COLOR,
                                child: const DetailsCard(
                                    icon: Icon(
                                      Icons.category,
                                      color: WHITE_COLOR,
                                    ),
                                    title: "Genre",
                                    content: ""),
                              ),
                              Shimmer.fromColors(
                                baseColor: OFF_BACKGROUND_COLOR,
                                highlightColor: OFF_PRIMARY_COLOR,
                                child: const DetailsCard(
                                    icon: Icon(
                                      Icons.timer,
                                      color: WHITE_COLOR,
                                    ),
                                    title: "Duration",
                                    content: ""),
                              ),
                              Shimmer.fromColors(
                                baseColor: OFF_BACKGROUND_COLOR,
                                highlightColor: OFF_PRIMARY_COLOR,
                                child: const DetailsCard(
                                    icon: Icon(
                                      Icons.star_rate,
                                      color: WHITE_COLOR,
                                    ),
                                    title: "Rating",
                                    content: ""),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: 50.sp,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: 50.sp,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Container(
                        height: 15.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: OFF_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
