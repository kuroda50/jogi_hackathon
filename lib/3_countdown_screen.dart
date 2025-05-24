import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart'; // 音声再生用
import '4_game_over_screen.dart';
import 'services/ai.dart'; // AIサービスをインポート

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> with TickerProviderStateMixin {
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
  final GeminiApiService _apiService = GeminiApiService(); // AIサービスのインスタンス
  String _evaluationResult = ''; // AIの評価結果を格納
  bool _isScary = false; // 恐怖演出フラグ

  @override
  void initState() {
    super.initState();

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
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          _backgroundColor = _random.nextInt(10) < 2
              ? Colors.red.withOpacity(0.5)
              : Colors.black;
        });
      });

    _currentMessage = _messages[_random.nextInt(_messages.length)];
    _startTimer();
    _updateMessage();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_timeRemaining <= 0.1) {
          timer.cancel();
          _navigateToGameOver();
        } else {
          // _timeRemaining -= 0.1;
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
  void _navigateToGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false, // ユーザーが閉じられないようにする
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'kazukihiro512099_TP_V.jpg', // 不気味な画像
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
          builder: (context) => const GameOverScreen(),
        ),
      );
    });

    playJumpScare(); // ジャンプスケア音を再生
  }

  void _playTickSound() {
    SystemSound.play(SystemSoundType.alert); // 不気味な音を再生
  }

  Future<void> _evaluateHumor() async {
    final List<Map<String, String>> inputData = [
      // {"cause": "バナナの皮で滑って転倒", "will": "冷蔵庫のプリンは妹のもの"},
      // {"cause": "スライムに溺れて", "will": "世界は平和だった"},
      // {"cause": "無限ループに巻き込まれた", "will": "breakを忘れるな"},
      {"cause": "バナナの皮で滑って転倒", "will": "以上です"},
      {"cause": "スライムに溺れて", "will": "終了します"},
      {"cause": "無限ループに巻き込まれた", "will": "保存してください"}
    ];
    try {
      final List<Map<String, dynamic>> result =
          await _apiService.evaluateHumor(inputData);
      setState(() {
        _evaluationResult = result.toString();

        // 面白い数と面白くない数をカウント
        final int funnyCount =
            result.where((item) => item['面白い'] == true).length;
        final int notFunnyCount =
            result.where((item) => item['面白い'] == false).length;

        // 面白くなければ、怖がらせる
        _isScary = funnyCount < notFunnyCount;
      });

      if (_isScary) {
        _triggerHorrorEffect(); // 恐怖演出をトリガー
      } else {
        _triggerBrightEffect(); // 明るい演出をトリガー
      }
    } catch (e) {
      setState(() {
        _evaluationResult = 'エラーが発生しました: $e';
        print(_evaluationResult);
      });
    }
  }

  void _triggerHorrorEffect() {
    // 背景色を赤に変更
    setState(() {
      _backgroundColor = Colors.red.withOpacity(0.8);
    });

    // 恐怖音を再生
    playJumpScare();
  }

  void _triggerBrightEffect() {
    // 背景色を明るい色に変更
    setState(() {
      _backgroundColor = Colors.blue[50]!; // 明るい背景色
    });

    // ポジティブなメッセージを表示
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            '良い結果！',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: const Text(
            '面白い結果が得られました！次に進みましょう！',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '閉じる',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _evaluateHumor, // 評価を開始
            child: const Text('評価を開始'),
          ),
          const SizedBox(height: 20),
          Text(
            _evaluationResult,
            style: TextStyle(
              fontSize: 18,
              color: _isScary ? Colors.red : Colors.white, // 面白くない場合は赤文字
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _timeRemaining.toStringAsFixed(1), // カウントダウン表示
            style: const TextStyle(
              color: Colors.red,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
