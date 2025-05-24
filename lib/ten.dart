import 'package:flutter/material.dart';
import 'dart:async';
import 'ketsu.dart';

class Ten extends StatefulWidget {
  const Ten({super.key});

  @override
  State<Ten> createState() => _TenState();
}

class _TenState extends State<Ten> {
  late Timer _timer;
  double _timeRemaining = 5.0;

  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_timeRemaining <= 0.1) {
          timer.cancel();
          _navigateToKetsu();
        } else {
          _timeRemaining -= 0.1; // 0.01秒減少
        }
      });
    });
  }

  void _navigateToKetsu() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Ketsu(),
        ));
    playJumpScare();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
              _timeRemaining.toStringAsFixed(1), // 小数点以下2桁まで表示
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
