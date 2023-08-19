import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  final String name;

  const CategoryCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.sp,
          height: 50.sp,
          margin: EdgeInsets.symmetric(horizontal: 5.sp),
          decoration: BoxDecoration(
            color: OFF_BACKGROUND_COLOR,
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: Center(
            child: Text(
              "C",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: WHITE_COLOR,
                  ),
            ),
          ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: OFF_PRIMARY_COLOR,
              ),
        ),
      ],
    );
  }
}
