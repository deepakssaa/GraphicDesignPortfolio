import 'package:designsmith/app_theme.dart';
import 'package:designsmith/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:designsmith/fav_provide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Designsmith',
        theme: ThemeData(
          fontFamily: 'kanit',
          colorScheme: ColorScheme.light(
            primary: AppTheme.primary,
            secondary: AppTheme.accent,
            surface: AppTheme.surface,
          ),
          scaffoldBackgroundColor: AppTheme.surface,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'kanit',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
            iconTheme: IconThemeData(color: AppTheme.textPrimary),
          ),
        ),
        home: const Welcome(),
      ),
    );
  }
}
