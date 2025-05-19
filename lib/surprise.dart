import 'package:flutter/material.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("バックグラウンドタスク実行中: $taskName");

    // 通知の代わりにログやサーバー通信などの処理を記述する
    // 例: printやDB処理など
    print("ここにAPI通信やログ保存などを書く");

    return Future.value(true); // タスクが正常終了したことを示す
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Workmanagerの初期化
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // デバッグ中のみ true。本番では false
  );

  // 一度きりのタスク登録
  await Workmanager().registerOneOffTask(
    "uniqueTaskId",   // タスクのID（ユニークにする）
    "simpleTaskName", // タスク名
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("バックグラウンドタスク登録済み")),
      ),
    );
  }
}
