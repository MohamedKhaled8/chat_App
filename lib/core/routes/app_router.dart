// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:chatapp/core/routes/routes.dart';
// import '../../features/chat/ui/chat_screen.dart';
// import '../../features/chat/ui/chat_user_card.dart';
// import 'package:chatapp/features/home/home_screen.dart';
// import 'package:chatapp/core/helper/firebase_helper.dart';
// import 'package:chatapp/features/home/data/model/chat_user.dart';
// import 'package:chatapp/features/chat/logic/cubit/chat_cubit.dart';
// import 'package:chatapp/features/home/logic/cubit/home_cubit.dart';
// import 'package:chatapp/features/splash_screen/splash_screen.dart';
// import '../../features/chat/logic/cubit/chat_user_card_cubit.dart';
// import 'package:chatapp/features/auth/login_screen/login_screen.dart';
// import '../../features/auth/login_screen/logic/cubit/login_cubit.dart';
// import 'package:chatapp/features/profile_screen/ui/profile_screen.dart';
// import 'package:chatapp/features/profile_screen/logic/cubit/proifle_cubit.dart';

// class AppRouter {
//   final ChatUser? chatUser;
//   AppRouter(this.chatUser);

//   Route generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashScreen:
//         return MaterialPageRoute(
//           builder: (_) => const SplasScreen(),
//         );

//       case Routes.homeScreen:
//         return MaterialPageRoute(
//           builder: (_) => MultiBlocProvider(
//             providers: [
//               BlocProvider(create: (_) => HomeCubit()),
//               BlocProvider(create: (_) => ProfileCubit(chatUser!)),
//               BlocProvider(
//                   create: (_) => ChatUserCardCubit(
//                         chatUser ??
//                             ChatUser(
//                                 image: "",
//                                 about: "",
//                                 name: "",
//                                 createdAt: "",
//                                 isOnline: true ?? false,
//                                 id: "",
//                                 lastActive: "",
//                                 email: "",
//                                 pushToken: ""),
//                       )),
//             ],
//             child: const HomeScreen(),
//           ),
//         );

//       case Routes.loginScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider<LoginCubit>(
//             create: (BuildContext context) => LoginCubit(),
//             child: const LoginScreen(),
//           ),
//         );

//       case Routes.profileScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider<ProfileCubit>(
//             create: (context) => ProfileCubit(chatUser!),
//             child: ProfileScreen(
//               chatUser: FirebaseHelper.me,
//             ),
//           ),
//         );
//       case Routes.chatScreen:
//         return chatUser != null
//             ? MaterialPageRoute(
//                 builder: (_) => BlocProvider<ChatCubit>(
//                   create: (BuildContext context) => ChatCubit(chatUser!),
//                   child: ChatScreen(
//                     user: chatUser!,
//                   ),
//                 ),
//               )
//             : _errorRoute(settings);

//       case Routes.chatUserCard:
//         return chatUser != null
//             ? MaterialPageRoute(
//                 builder: (_) => BlocProvider<ChatUserCardCubit>(
//                   create: (BuildContext context) =>
//                       ChatUserCardCubit(chatUser!),
//                   child: ChatUserCard(
//                     user: chatUser!,
//                   ),
//                 ),
//               )
//             : _errorRoute(settings);

//       default:
//         return _errorRoute(settings);
//     }
//   }

//   MaterialPageRoute _errorRoute(RouteSettings settings) {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         body: Center(
//           child: Text("No route defined for ${settings.name}"),
//         ),
//       ),
//     );
//   }
// }
