import 'package:flutter/material.dart';
import 'custom_text_lato.dart';
import 'package:sizer/sizer.dart';

class CustomDisplayError extends StatelessWidget {
  const CustomDisplayError({Key key, this.message, this.color, this.title})
      : super(key: key);
  final String message;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextLato(
            title,
            size: 15.0.sp,
            color: color ?? Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextLato(
            message,
            size: 10.0.sp,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
