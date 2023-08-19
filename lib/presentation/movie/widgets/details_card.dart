import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:sizer/sizer.dart';

class DetailsCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String content;

  const DetailsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: WHITE_COLOR, width: 1.sp)),
      child: Column(
        children: [
          icon,
          SizedBox(
            height: 5.sp,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: WHITE_COLOR,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: WHITE_COLOR.withOpacity(0.5),
                  fontSize: 11.sp,
                ),
          ),
        ],
      ),
    );
  }
}
