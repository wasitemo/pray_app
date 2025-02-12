import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pray_app/ui/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 34, 37, 47),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: Color.fromARGB(255, 34, 37, 49),
        ),
        textTheme: TextTheme().copyWith(
            displaySmall: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
            titleSmall: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            titleMedium: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
      title: 'Pray App',
      home: ProviderScope(child: const HomeScreen()),
    );
  }
}
