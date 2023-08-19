import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/providers/bottom_navigation_bar_provider.dart';
import 'package:warikanking_frontend/providers/hide_password_provider.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';
import 'package:warikanking_frontend/views/accounts/signup_page.dart';
import 'package:warikanking_frontend/views/events/join_event_page.dart';
import 'package:warikanking_frontend/views/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChangeHidePassword()),
        ChangeNotifierProvider(create: (context) => SetSignupErrorMessage()),
        ChangeNotifierProvider(create: (context) => SetSigninErrorMessage()),
        ChangeNotifierProvider(create: (context) => BottomNavigationBarProvider()),
      ],
      child: MaterialApp(
        title: "warikanking",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.zenKurenaidoTextTheme(
              Theme.of(context).textTheme
          ),
        ),
        home: Screen(),
      ),
    );
  }
}
