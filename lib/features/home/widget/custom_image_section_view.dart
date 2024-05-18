import 'package:flutter/material.dart';
import '../../../core/helper/botton_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageSectionView extends StatelessWidget {
  const CustomImageSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w, right: 15.0.h),
      child: DottedBorder(
        color: Colors.white,
        strokeWidth: 1,
        dashPattern: const [2, 2, 2, 2],
        borderType: BorderType.Circle,
        strokeCap: StrokeCap.round,
        radius: const Radius.circular(20),
        child: ClipOval(
          child: Center(
            child: IconButton(
              onPressed: () {
                showBottomSheetHome(context);
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
