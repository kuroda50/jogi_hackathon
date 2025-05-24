import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Header(),
        body: Container(),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}