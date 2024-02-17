import 'package:flutter/material.dart';
import 'package:medbox/routes.dart';
import 'package:medbox/screens/authscreen/login.dart';
import 'package:medbox/screens/authscreen/signup.dart';
import 'package:medbox/screens/mainpage.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:medbox/service/authservice.dart';
import 'package:medbox/service/userservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await AuthService.init();

  User.initializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0C1320),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF24CCCC)),
          appBarTheme:
              const AppBarTheme(color: Color(0xFF0C1320), elevation: 2),
          useMaterial3: true,
        ),
        initialRoute: (AuthService.accessToken == null ||
                AuthService.accessToken!.isEmpty)
            ? MyRoutes.login
            : MyRoutes.main,
        routes: {
          MyRoutes.login: (p0) => const LoginPage(),
          MyRoutes.signup: (p0) => const SignUpPage(),
          //   MyRoutes.information: (p0) => const InformationPage(),
          MyRoutes.main: (p0) => const MainPage(),
        });
  }
}
