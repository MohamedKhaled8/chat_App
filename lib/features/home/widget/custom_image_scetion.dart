import 'package:flutter/material.dart';
import '../logic/cubit/home_cubit.dart';
import 'custom_image_section_view.dart';
import 'custom_image_section_view_and_add.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomImageSection extends StatelessWidget {
  const CustomImageSection({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          height: 115.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeCubit.imageList.length + 1,
            itemBuilder: (context, index) {
              if (index == homeCubit.imageList.length) {
                return const CustomImageSectionView();
              } else {
                return CustomImageSectionViewAndAdd(
                  homeCubit: homeCubit,
                  index: index,
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}