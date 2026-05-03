import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/ui/welcome.dart';

void main() {
  runApp(const MedievalWebsite());
}

class MedievalWebsite extends StatelessWidget {
  const MedievalWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Süleyman Emre Parlak',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.almendraTextTheme(Theme.of(context).textTheme),
      ),
      home: const WelcomeScreen(),
    );
  }
}