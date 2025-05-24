import 'package:flutter/material.dart';
import 'package:jogi_hackathon/create_post.dart';
import 'package:jogi_hackathon/models/theme_data.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});
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
                itemCount: (GameThemes.themeCount / 2).ceil(),
                itemBuilder: (context, row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (col) {
                      int index = row * 2 + col;
                      if (index >= GameThemes.themeCount) {
                        return const SizedBox.shrink();
                      }
                      final theme = GameThemes.getThemeAt(index);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePostScreen(
                                selectedTheme: theme.text,
                                selectedImageUrl: theme.imageUrl,
                              ),
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
                                  theme.imageUrl,
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
                                      theme.text,
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
