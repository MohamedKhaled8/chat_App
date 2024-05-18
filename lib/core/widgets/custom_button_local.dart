import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonLocal extends StatelessWidget {
  final String title;
  final double higth;
  final double width;
  final String image;
  final void Function()? onTap;
  const CustomButtonLocal({
    Key? key,
    required this.title,
    required this.higth,
    required this.width,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: higth.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: Row(
          children: [
            Image.asset(image),
            Center(
                child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            )),
          ],
        ),
      ),
    );
  }
}
