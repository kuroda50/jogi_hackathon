import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:jogi_hackathon/ki.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  await dotenv.load(fileName: 'env');  // .envファイルを読み込む
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // MyAppでラップ
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KiDart(),
      useInheritedMediaQuery: true, // DevicePreview対応
      builder: DevicePreview.appBuilder, // DevicePreview対応
      locale: DevicePreview.locale(context), // DevicePreview対応
    );
  }
}
