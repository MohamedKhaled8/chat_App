import 'package:flutter/material.dart';
import '../logic/cubit/home_cubit.dart';
import '../../chat/ui/chat_user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShowChat extends StatelessWidget {
  const CustomShowChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit()
        ..fetchUsers()
        ..intializ()
        ..loadProfileImageUrl(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Expanded(
            child: Container(
                height: 555.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff292F3F),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: BlocProvider(
                  create: (context) => HomeCubit()
                    ..intializ()
                    ..fetchUsers(),
                  child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                    var homeCubit = HomeCubit.get(context);

                    return ListView.builder(
                      key: UniqueKey(),
                      itemCount: homeCubit.isSearching
                          ? homeCubit.searchList.length
                          : homeCubit.list.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          user: homeCubit.isSearching
                              ? homeCubit.searchList[index]
                              : homeCubit.list[index],
                        );
                      },
                    );
                  }),
                )),
          );
        },
      ),
    );
  }
}
