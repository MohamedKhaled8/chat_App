import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatapp/features/splash_screen/splash_screen.dart';


class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
          backgroundColor: Colors.white,
        )),
        title: 'Chat App',
        // initialRoute: Routes.homeScreen,
        // onGenerateRoute: appRouter.generateRoute,
        home: const SplasScreen(),
      ),
    );
  }
}
