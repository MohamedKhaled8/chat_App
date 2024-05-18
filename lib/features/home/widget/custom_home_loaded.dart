import 'dart:io';
import 'custom_show_chat.dart';
import 'package:flutter/material.dart';
import '../logic/cubit/home_cubit.dart';
import '../../../core/helper/app_bar.dart';
import '../../../core/helper/botton_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/custom_floating-action_button_home_screen.dart';

class CustomHomeLoaded extends StatefulWidget {
  const CustomHomeLoaded({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomHomeLoaded> createState() => _CustomHomeLoadedState();
}

class _CustomHomeLoadedState extends State<CustomHomeLoaded> {
  @override
  void dispose() {
    HomeCubit.get(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..fetchUsers()
        ..intializ()
        ..loadProfileImageUrl(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: WillPopScope(
              onWillPop: () {
                return homeCubit.isSearchingType();
              },
              child: Scaffold(
                backgroundColor: const Color(0xff182020),
                appBar: buildAppBarHomeScreen(context),
                floatingActionButton:
                    const CustomFloatingActionButtonHomeScreen(),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
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
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0.w, right: 15.0.h),
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
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0.w, right: 20.0.h),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            DottedBorder(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                              dashPattern: const [
                                                20,
                                                20,
                                                20,
                                                20
                                              ],
                                              padding:
                                                  const EdgeInsets.all(6).r,
                                              borderType: BorderType.Circle,
                                              strokeCap: StrokeCap.round,
                                              radius: const Radius.circular(20),
                                              child: ClipOval(
                                                child: Image.file(
                                                  File(homeCubit
                                                      .imageList[index]),
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
                              },
                            ),
                          ),
                        ]),
                      ),
                      const CustomShowChat(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
