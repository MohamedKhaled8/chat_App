import 'dart:io';
import 'package:flutter/material.dart';
import '../logic/cubit/home_cubit.dart';
import '../../../core/helper/botton_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomImageSectionViewAndAdd extends StatelessWidget {
  final int index;
  const CustomImageSectionViewAndAdd({
    Key? key,
    required this.index,
    required this.homeCubit,
  }) : super(key: key);

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w, right: 20.0.h),
      child: Column(
        children: [
          Stack(
            children: [
              DottedBorder(
                color: Colors.white,
                strokeWidth: 2,
                dashPattern: const [20, 20, 20, 20],
                padding: const EdgeInsets.all(6).r,
                borderType: BorderType.Circle,
                strokeCap: StrokeCap.round,
                radius: const Radius.circular(20),
                child: ClipOval(
                  child: Image.file(
                    File(homeCubit.imageList[index]),
                    width: 60.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50.h,
                left: 10.w,
                child: MaterialButton(
                  elevation: 1,
                  onPressed: () {
                    showBottomSheetHome(context);
                  },
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}