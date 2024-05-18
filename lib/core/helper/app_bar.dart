import 'firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/logic/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/profile_screen/ui/profile_screen.dart';

AppBar buildAppBarHomeScreen(BuildContext context) {
  var homeCubit = context.read<HomeCubit>();

  return AppBar(
    elevation: 0.0,
    backgroundColor: const Color(0xff182020),
    leading: IconButton(
      icon: const Icon(
        CupertinoIcons.home,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
    title: homeCubit.isSearching
        ? TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Name, Email, ...',
            ),
            autofocus: true,
            style: TextStyle(
              fontSize: 17.sp,
              letterSpacing: 0.5,
            ),
            onChanged: (val) {
              homeCubit.clearSearch();

              homeCubit.searchType(val);
            },
          )
        : const Text(
            'We Chat',
            style: TextStyle(color: Colors.white),
          ),
    actions: [
      IconButton(
          onPressed: () {
            homeCubit.isSearch();
          },
          icon: Icon(
            homeCubit.isSearching
                ? CupertinoIcons.clear_circled_solid
                : Icons.search,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                          chatUser: FirebaseHelper.me,
                        )));
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ))
    ],
  );
}
