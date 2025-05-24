import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart'; // 音声再生用
import 'ketsu.dart';

class Ten extends StatefulWidget {
  const Ten({super.key});

  @override
  State<Ten> createState() => _TenState();
}

class _TenState extends State<Ten> with TickerProviderStateMixin {
  late Timer _timer;
  double _timeRemaining = 5.0;
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late AnimationController _colorController; // 背景色点滅用
  Color _backgroundColor = Colors.black;
  final List<String> _messages = [
    "何かが近づいている...",
    "逃げられない...",
    "振り返らないで...",
    "時間がない..."
  ];
  String _currentMessage = "";
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _currentMessage = _messages[_random.nextInt(_messages.length)];
    _startTimer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 点滅の頻度を控えめに
    )..addListener(() {
        setState(() {
          // 背景色を控えめに変更（暗めの赤と黒を使用）
          _backgroundColor = _random.nextInt(10) < 2
              ? Colors.red.withOpacity(0.5) // 暗めの赤
              : Colors.black;
        });
      });

    _updateMessage();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_timeRemaining <= 0.1) {
          timer.cancel();
          _navigateToKetsu();
        } else {
          _timeRemaining -= 0.1;
          if (_timeRemaining <= 1.0) {
            _shakeController.forward(from: 0.0); // 揺れを開始
            _playTickSound(); // 音を再生
            _colorController.forward(from: 0.0); // 背景色点滅を開始
          }
        }
      });
    });
  }

  void _updateMessage() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining <= 0.1) {
        timer.cancel();
      } else {
        setState(() {
          _currentMessage = _messages[_random.nextInt(_messages.length)];
        });
      }
    });
  }

  void _navigateToKetsu() {
    showDialog(
      context: context,
      barrierDismissible: false, // ユーザーが閉じられないようにする
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/kazukihiro512099_TP_V.jpg', // 不気味な画像
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );

    // 0.5秒後に画面遷移
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Ketsu(),
        ),
      );
    });

    playJumpScare(); // ジャンプスケア音を再生
  }

  void _playTickSound() {
    SystemSound.play(SystemSoundType.alert); // 不気味な音を再生
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _shakeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, // 背景色を動的に変更
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final offset =
              _shakeController.value * 10.0 * (_random.nextBool() ? 1 : -1);
          return Transform.translate(
            offset: Offset(offset, offset),
            child: child,
          );
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    _timeRemaining.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _animationController,
                    child: Text(
                      _currentMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Creepster', // 不気味なフォント
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
