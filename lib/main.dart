import 'package:flutter/material.dart';
import 'package:tlubook/views/book_view.dart';
import 'package:tlubook/views/books_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "SourceSansPro"),
      home: BooksSplash(),
    );
  }
}


