import 'package:flutter/material.dart';
import 'package:jogi_hackathon/3_countdown_screen.dart';
import 'package:jogi_hackathon/models/theme_data.dart';

class CreatePostScreen extends StatefulWidget {
  final String selectedTheme;
  final String selectedImageUrl;

  const CreatePostScreen({
    super.key,
    required this.selectedTheme,
    required this.selectedImageUrl,
  });
  @override
  CreatePostScreenState createState() => CreatePostScreenState();
}

class CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController controller = TextEditingController(); // 入力管理
  int pressCount = 0; //確定ボタンを押した回数
  // GameThemesから取得したお題データを使用
  List<ThemeItem> get _themeItems => [
    GameThemes.getThemeAt(0),
    GameThemes.getThemeAt(1),
    GameThemes.getThemeAt(2),
  ];
  
  // お題のテキストだけを取得するゲッター
  List<String> get topics => _themeItems.map((theme) => theme.text).toList();
  
  // 画像URLだけを取得するゲッター
  List<String> get images => _themeItems.map((theme) => theme.imageUrl).toList();
    // カウントのみ使用
  final int maxPressCount = 3;

  late String userText; //初期メッセージ  @override
  void initState() {
    super.initState();
    // 初期メッセージを設定
    userText = '「${widget.selectedTheme}」によって...';
    
    // TextFieldに初期テキストも設定しておく
    controller.addListener(() {
      // テキストが空の場合はデフォルトメッセージを表示
      if (controller.text.isEmpty) {
        userText = '「${widget.selectedTheme}」によって...';
      }
    });
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
                    ),                    Text(
                      widget.selectedTheme, // 選択されたお題を表示
                      style: const TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),              // テキスト表示部（ユーザー入力反映）
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text(
                    userText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),const SizedBox(height: 20),              // 入力欄 - 入力時に自動更新するように変更
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: controller,
                  onChanged: (text) {
                    // テキスト変更時に自動的に表示を更新
                    setState(() {
                      userText = text.isEmpty ? '「${widget.selectedTheme}」によって...' : text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: '最後の言葉を入力してください',
                    hintText: '「${widget.selectedTheme}」の状況で言いそうなこと...',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    pressCount++;
                    
                    if (pressCount < maxPressCount) {
                      // まだカウントが残っている場合
                      controller.clear();
                      // デフォルトのテキストを表示
                      userText = '「${widget.selectedTheme}」によって...';
                    } else {
                      // 最後の確定ボタンクリックでカウントダウン画面へ
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CountdownScreen()),
                      );
                    }
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(pressCount < maxPressCount - 1 ? '次へ進む' : '決定'),
                    const SizedBox(width: 8),
                    Icon(pressCount < maxPressCount - 1 ? Icons.arrow_forward : Icons.check_circle),
                  ],
                ),
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
