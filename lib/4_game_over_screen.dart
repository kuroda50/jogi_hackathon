import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:jogi_hackathon/1_theme_selection_screen.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({super.key});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  final List<Offset> _bloodPositions = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    playJumpScare();
    _spawnBlood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, //ホラー風の背景
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: const Text('死にました'),
        ),
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 600,
                child: Image.asset("assets/horror430_TP_V.webp"),
              ),
            ),
            // 血の画像を時間差で出す
            for (final position in _bloodPositions)
              Positioned(
                left: position.dx,
                top: position.dy,
                child: Image.asset(
                  'assets/30392738_p2_master1200_transparent.png',
                  width: 200,
                  height: 200,
                ),
              ),
            // 最初に戻るボタン
            Positioned(
              bottom: 50,
              left: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ThemeSelectionScreen()),
                    (Route<dynamic> route) => false, // 全ての前の画面を削除
                  );
                },
                child: const Icon(Icons.refresh),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ));
  }

  void _spawnBlood() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        // ウィジェットがまだマウントされているかチェック
        setState(() {
          _bloodPositions.add(Offset(
            _random.nextDouble() * 300 + 50, // 横方向ランダム (例: 50〜350)
            _random.nextDouble() * 400 + 100, // 縦方向ランダム (例: 100〜500)
          ));
        });
      }
    }
  }
}

Future<void> playJumpScare() async {
  final player = AudioPlayer();
  await player.play(AssetSource('hito_ge_himei01.mp3'));
}
