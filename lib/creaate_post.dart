import 'package:flutter/material.dart';
import 'package:jogi_hackathon/ten.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BananaScreen(
        selectedTheme: 'デフォルトのお題',
        selectedImageUrl: 'https://via.placeholder.com/150',
      ),
    );
  }
}

class BananaScreen extends StatefulWidget {
  final String selectedTheme;
  final String selectedImageUrl;

  const BananaScreen({
    super.key,
    required this.selectedTheme,
    required this.selectedImageUrl,
  });

  @override
  BananaScreenState createState() => BananaScreenState();
}

class BananaScreenState extends State<BananaScreen> {
  final TextEditingController controller = TextEditingController(); // 入力管理
  int pressCount = 0; //確定ボタンを押した回数

  //お題と画像リスト
  final List<String> topics = [
    'バナナの皮で滑った',
    '階段から転げ落ちた',
    'UFOに連れ去られた',
  ];
  final List<String> images = [
    'https',
    'https',
    'https',
  ];
  final List<String> examples = [
    '例/そんなバカな',
    '例/バナナの皮で耐えることはできたのに（泣）',
    '例/UFOを撃墜できれば...',
  ];

  late String userText; //初期メッセージ

  @override
  void initState() {
    super.initState();
    // 選択されたお題に応じて初期メッセージを設定
    userText = '例: 「${widget.selectedTheme}」なんて...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遺言を考えよう'),
        automaticallyImplyLeading: false, // 戻るボタンを非表示
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          // スクロール可能にする（キーボード対策)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 選択されたお題を表示
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      '選択されたお題:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.selectedTheme,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // バナナの画像とテキスト
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      widget.selectedImageUrl, // 選択された画像を使用
                      width: 200,
                    ),
                    Text(
                      topics[pressCount.clamp(0, 2)],
                      style: const TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // テキスト表示部（ユーザー入力反映）
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blue[900],
                child: Container(
                  color: Colors.cyanAccent[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text(
                    userText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 入力欄とボタン
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: '最後の言葉を入力してください',
                    hintText: '「${widget.selectedTheme}」の状況で言いそうなこと...',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    userText = controller.text;
                  });
                },
                child: const Text('更新'),
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 入力内容でuserTxetを更新
                    pressCount++;
                    if (pressCount < 3) {
                      userText = examples[pressCount.clamp(0, 2)];
                      controller.clear();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Ten()),
                      );
                    }
                  });
                },
                child: const Text('確定'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('次の画面'),
        automaticallyImplyLeading: false, // 戻るボタンを非表示),
      ),
      body: const Center(
        child: Text('ここが次の画面です'),
      ),
    );
  }
}
