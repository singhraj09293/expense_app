import 'package:expense_app/screen/home.dart';
import 'package:expense_app/screen/login_screen.dart';
import 'package:expense_app/screen/main_screen.dart';
import 'package:expense_app/widget/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00D084),
          secondary: Color(0xFF191C1B),
          tertiary: Color(0xffAFC2AD),
        ),
      ),
      routes: {
        '/home':(context) => Home(),
        '/login':(context) => LoginScreen(),
        '/main':(context)=>MainScreen(),
      },
      home: AuthWrapper(),
    );
  }
}
