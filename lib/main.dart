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
        home: Welcome(),
        theme: ThemeData(fontFamily: 'kanit'),
      ),
    );
  }
}
