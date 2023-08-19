import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:sizer/sizer.dart';

class GenericButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const GenericButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.sp,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
