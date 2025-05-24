import 'package:flutter/material.dart';

class TimeShowScreen extends StatefulWidget {
  const TimeShowScreen({Key? key}) : super(key: key);

  @override
  State<TimeShowScreen> createState() => _TimeShowScreenState();
}

class _TimeShowScreenState extends State<TimeShowScreen> {
  late DateTime currentTime;
  late DateTime futureTime;

  @override
  void initState() {
    super.initState();
    // 現在の時刻を取得
    currentTime = DateTime.now();
    // 3分後の時刻を計算
    futureTime = currentTime.add(const Duration(minutes: 3));
  }

  String _formatTime(DateTime time) {
    // 時刻のフォーマット (例: 14:30:25)
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 黒背景
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // 戻るボタンを白に
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              _formatTime(futureTime),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
