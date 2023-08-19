import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_bloc.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_event.dart';
import 'package:flutter_movies_app/presentation/main/explore/bloc/explore_state.dart';
import 'package:flutter_movies_app/presentation/main/explore/widgets/movie_search_card.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:flutter_movies_app/utils/widgets/generic_text_field.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  final bloc = sl<ExploreBloc>();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(customScrollListener);
    return BlocBuilder(
      bloc: bloc,
      builder: (_, state) {
        if (state is LoadingSearch) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 65.sp,
                  ),
                  GenericTextField(
                    hint: "enter the movie name",
                    icon: const Icon(
                      Icons.search,
                      color: PRIMARY_COLOR,
                    ),
                    controller: bloc.searchCont,
                    onChange: (value) {
                      bloc.add(ChangedSearch(value));
                    },
                  ),
                  SizedBox(
                    height: 200.sp,
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: 65.sp,
                ),
                GenericTextField(
                  hint: "enter the movie name",
                  icon: const Icon(
                    Icons.search,
                    color: PRIMARY_COLOR,
                  ),
                  controller: bloc.searchCont,
                  onChange: (value) {
                    bloc.add(ChangedSearch(value));
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 200.sp,
                      mainAxisSpacing: 30.sp,
                      crossAxisSpacing: 8.sp,
                    ),
                    // shrinkWrap: true,
                    itemCount: bloc.movies.length,
                    itemBuilder: (_, index) {
                      return MovieSearchCard(
                        name: bloc.movies[index].title,
                        poster: bloc.movies[index].poster,
                        rating: bloc.movies[index].rating,
                        adult: bloc.movies[index].adult,
                      );
                    },
                  ),
                ),
                if (state is LoadingMore) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: OFF_BACKGROUND_COLOR,
                      highlightColor: OFF_PRIMARY_COLOR,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MovieSearchCard(
                            name: '',
                            poster: '',
                          ),
                          SizedBox(
                            width: 23.sp,
                          ),
                          MovieSearchCard(
                            name: '',
                            poster: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  customScrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      bloc.add(ScrollMore());
    }
  }
}
