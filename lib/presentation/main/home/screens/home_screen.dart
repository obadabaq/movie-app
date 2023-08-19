import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_bloc.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_event.dart';
import 'package:flutter_movies_app/presentation/main/home/bloc/home_state.dart';
import 'package:flutter_movies_app/presentation/main/home/widgets/category_card.dart';
import 'package:flutter_movies_app/presentation/main/home/widgets/movie_card.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:flutter_movies_app/utils/route_generator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final bloc = sl<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.add(InitHome());
    return BlocBuilder(
      bloc: bloc,
      builder: (_, HomeState state) {
        return RefreshIndicator(
          onRefresh: () {
            bloc.add(InitHome());
            return Future.value(true);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Welcome section
                  SizedBox(
                    height: 65.sp,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome ${state is GotUserSuccessfully ? bloc.userModel!.username : ""}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: WHITE_COLOR.withOpacity(0.5),
                                ),
                          ),
                          Text(
                            "Bring popcorn, it's movie time.",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: WHITE_COLOR,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),

                  ///Categories section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: WHITE_COLOR,
                                ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              "See all",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: PRIMARY_COLOR, fontSize: 10.sp),
                            ),
                            SizedBox(
                              width: 2.sp,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: PRIMARY_COLOR,
                              size: 13,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  if (!bloc.loadingCategories) ...[
                    SizedBox(
                      height: 65.sp,
                      child: ListView.builder(
                        itemCount: bloc.categories.length > 7
                            ? 7
                            : bloc.categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryCard(
                              name: bloc.categories[index].name);
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 65.sp,
                      child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Shimmer.fromColors(
                            baseColor: OFF_BACKGROUND_COLOR,
                            highlightColor: OFF_PRIMARY_COLOR,
                            child: const CategoryCard(name: ""),
                          );
                        },
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 30.sp,
                  ),

                  ///Trending movies section
                  Text(
                    "Trending Movies",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: WHITE_COLOR,
                        ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  if (!bloc.loadingTrendingMovies) ...[
                    SizedBox(
                      height: 170.sp,
                      child: ListView.builder(
                        itemCount: bloc.trendingMovies.length > 7
                            ? 7
                            : bloc.trendingMovies.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.MOVIE_DETAILS_SCREEN,
                                arguments: {
                                  "movieId": bloc.trendingMovies[index].id
                                },
                              );
                            },
                            child: MovieCard(
                              name: bloc.trendingMovies[index].title,
                              rating: bloc.trendingMovies[index].rating,
                              adult: bloc.trendingMovies[index].adult,
                              poster: bloc.trendingMovies[index].poster,
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 170.sp,
                      child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Shimmer.fromColors(
                            baseColor: OFF_BACKGROUND_COLOR,
                            highlightColor: OFF_PRIMARY_COLOR,
                            child: const MovieCard(
                              name: "",
                              rating: null,
                              adult: null,
                              poster: "",
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  SizedBox(
                    height: 30.sp,
                  ),

                  ///Upcoming movies section
                  Text(
                    "Upcoming Movies",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: WHITE_COLOR,
                        ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  if (!bloc.loadingUpcomingMovies) ...[
                    SizedBox(
                      height: 170.sp,
                      child: ListView.builder(
                        itemCount: bloc.upcomingMovies.length > 7
                            ? 7
                            : bloc.upcomingMovies.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.MOVIE_DETAILS_SCREEN,
                                arguments: {
                                  "movieId": bloc.upcomingMovies[index].id
                                },
                              );
                            },
                            child: MovieCard(
                              name: bloc.upcomingMovies[index].title,
                              rating: bloc.upcomingMovies[index].rating,
                              adult: bloc.upcomingMovies[index].adult,
                              poster: bloc.upcomingMovies[index].poster,
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 170.sp,
                      child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Shimmer.fromColors(
                            baseColor: OFF_BACKGROUND_COLOR,
                            highlightColor: OFF_PRIMARY_COLOR,
                            child: const MovieCard(
                              name: "",
                              rating: null,
                              adult: null,
                              poster: "",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 30.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
