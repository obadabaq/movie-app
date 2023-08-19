import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:sizer/sizer.dart';

class GenericTextField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final TextEditingController controller;
  final Function(String)? onChange;
  final bool obscure;

  const GenericTextField({
    Key? key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    required this.controller,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.sp,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onChange,
        obscureText: obscure,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: OFF_BACKGROUND_COLOR),
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.5)),
              borderSide: BorderSide(color: PRIMARY_COLOR),
            ),
            suffixIcon: icon,
            iconColor: PRIMARY_COLOR,
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: OFF_BACKGROUND_COLOR)),
      ),
    );
  }
}
