import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Ketsu extends StatefulWidget {
  const Ketsu({super.key});

  @override
  State<Ketsu> createState() => _KetsuState();
}

class _KetsuState extends State<Ketsu> {
  @override
  void initState() {
    super.initState();
    // _playJumpScare();
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
          ],
        ));
  }
}

Future<void> _playJumpScare() async {
  final player = AudioPlayer();
  await player.play(AssetSource('hito_ge_himei01.mp3'));
}
