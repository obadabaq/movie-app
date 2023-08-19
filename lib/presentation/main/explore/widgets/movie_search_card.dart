import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieSearchCard extends StatelessWidget {
  final String name;
  final String poster;
  final double? rating;
  final bool? adult;

  const MovieSearchCard({
    Key? key,
    required this.name,
    required this.poster,
    this.rating,
    this.adult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110.sp,
          height: 150.sp,
          margin: EdgeInsets.symmetric(horizontal: 5.sp),
          decoration: BoxDecoration(
            color: OFF_BACKGROUND_COLOR,
            borderRadius: BorderRadius.circular(25),
          ),
          child: poster.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      '$IMAGE_BASE_URL$poster',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Shimmer.fromColors(
                          baseColor: OFF_BACKGROUND_COLOR,
                          highlightColor: OFF_PRIMARY_COLOR,
                          child: Container(
                            width: 110.sp,
                            height: 150.sp,
                            decoration: BoxDecoration(
                              color: OFF_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(12.5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container(),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Container(
          width: 100.sp,
          alignment: Alignment.center,
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: WHITE_COLOR,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
        rating != null
            ? Text(
                "$rating • ${adult != null ? adult == true ? "R" : "PG-13" : ""}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: OFF_PRIMARY_COLOR,
                    ),
              )
            : Container(),
      ],
    );
  }
}
