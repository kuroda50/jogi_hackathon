import 'package:flutter/material.dart';

// BananaScrean画面の仮実装
class BananaScrean extends StatelessWidget {
  const BananaScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text('BananaScrean'),
        backgroundColor: Colors.yellow[300],
      ),
      body: const Center(
        child: Text(
          'バナナ画面です🍌',
          style: TextStyle(fontSize: 32, color: Colors.brown),
        ),
      ),
    );
  }
}

class KiDart extends StatelessWidget {
  const KiDart({super.key});

  // 画像とテキストのリストを用意
  static const List<String> imageUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
  ];

  static const List<String> texts = [
    'フクロウ1',
    '森の風景2',
    '山の景色3',
    '湖4',
    '夕焼け5',
    '猫6',
    '犬7',
    '花8',
    '山9',
    '森10',
    '川11',
    '空12',
    '鳥13',
    '草原14',
    '木15',
    'フクロウ16',
    '山17',
    '森18',
    '湖19',
    '夕焼け20',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 元の配色に戻す
      child: Column(
        children: [
          const SizedBox(height: 32),
          const Text(
            'お題を選んでしね',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black, // 元の配色
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (col) {
                    int index = row * 2 + col;
                    // 範囲外チェック
                    if (index >= imageUrls.length || index >= texts.length) {
                      return const SizedBox.shrink();
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BananaScrean(),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 160,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[200], // 元の配色
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue[100]!,
                              blurRadius: 8,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                              color: Colors.blue.withOpacity(0.5),
                              colorBlendMode: BlendMode.lighten,
                            ),
                            Text(
                              texts[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
