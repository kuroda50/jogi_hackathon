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
        elevation: 2,
      ),
      body: const Center(
        child: Text(
          'バナナ画面です🍌',
          style: TextStyle(
              fontSize: 32, color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class KiDart extends StatelessWidget {
  const KiDart({super.key});

  // 画像とテキストのリストを用意
  static const List<String> imageUrls = [
    'https://thumb.ac-illust.com/b4/b46b3b4ec746875e0d5f1d41443bc0c8_w.jpeg',
    'https://th.bing.com/th/id/OIP.ubYGHSysaoytCnjzgDgwvQHaHb?rs=1&pid=ImgDetMain',
    'https://t4.ftcdn.net/jpg/00/22/55/35/360_F_22553579_0dnjs8dJmH0AcI5olDHwGptqscNe2yzs.jpg',
    'https://3.bp.blogspot.com/-E9hOwqPle4A/VahTxZAjCiI/AAAAAAAAv4w/QUCb8DsJHc8/s800/pose_dokkiri_daiseikou.png',
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
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  ];

  static const List<String> texts = [
    '割り箸が綺麗に割れなくて',
    '足つぼマッサージが痛すぎて',
    'ハッピーな粉を摂取しすぎてハッピー中毒ﾀﾋ',
    '落とし穴に底がなくて',
    '午後ティーを午前に飲んで',
    'いい波にのれなくて',
    'fpsで負けて',
    '森のくまさんに出会って',
    '二回見たら死ぬ絵を二度見して',
    '卒論間に合わなくて',
    '歩行者地獄にて500万台の車に引かれて',
    'タンスの角に小指をぶつけたショックで',
    'お寿司のわさびがツーンとしすぎて',
    '「UNO」を言い忘れて',
    'ブルースクリーンになって',
    'リア充の爆発に巻き込まれて',
    '踊ってない夜を知って',
    'パン食い競争でパンに食われて',
    'おばあちゃんの知恵袋を信じすぎて',
    '空にあこがれて',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('お題を選んでね'),
        backgroundColor: Colors.blue[300],
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '好きなお題をタップしてください',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (col) {
                      int index = row * 2 + col;
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
                          width: 140,
                          height: 140,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.18),
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.blue[100]!,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        size: 48, color: Colors.grey),
                                  ),
                                ),
                                // ↓ 画像の上の白いフィルターを少しだけ濃くする
                                Container(
                                  color: Colors.white
                                      .withOpacity(0.18), // ← 0.10から0.18に変更
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      texts[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            // 黒いふち
                                            offset: Offset(0, 0),
                                            blurRadius: 4,
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 4,
                                            color: Colors.black,
                                          ),
                                          Shadow(
                                            offset: Offset(-1, -1),
                                            blurRadius: 4,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
