// お題データを管理するクラス
class ThemeItem {
  final String text;
  final String imageUrl;

  const ThemeItem({
    required this.text,
    required this.imageUrl,
  });
}

// お題データの定数リスト
class GameThemes {
  static const List<ThemeItem> themes = [
    ThemeItem(
      text: '割り箸が綺麗に割れなくて',
      imageUrl:
          'https://thumb.ac-illust.com/b4/b46b3b4ec746875e0d5f1d41443bc0c8_w.jpeg',
    ),
    ThemeItem(
      text: '足つぼマッサージが痛すぎて',
      imageUrl:
          'https://th.bing.com/th/id/OIP.ubYGHSysaoytCnjzgDgwvQHaHb?rs=1&pid=ImgDetMain',
    ),
    ThemeItem(
      text: 'ハッピーな粉を摂取しすぎてハッピー中毒ﾀﾋ',
      imageUrl:
          'https://t4.ftcdn.net/jpg/00/22/55/35/360_F_22553579_0dnjs8dJmH0AcI5olDHwGptqscNe2yzs.jpg',
    ),
    ThemeItem(
      text: '落とし穴に底がなくて',
      imageUrl:
          'https://3.bp.blogspot.com/-E9hOwqPle4A/VahTxZAjCiI/AAAAAAAAv4w/QUCb8DsJHc8/s800/pose_dokkiri_daiseikou.png',
    ),
    ThemeItem(
      text: '午後ティーを午前に飲んで',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    ),
    ThemeItem(
      text: 'いい波にのれなくて',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    ),
    ThemeItem(
      text: 'fpsで負けて',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    ),
    ThemeItem(
      text: '森のくまさんに出会って',
      imageUrl: 'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
    ),
    ThemeItem(
      text: '二回見たら死ぬ絵を二度見して',
      imageUrl: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
    ),
    ThemeItem(
      text: '卒論間に合わなくて',
      imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    ),
    ThemeItem(
      text: '歩行者地獄にて500万台の車に引かれて',
      imageUrl: 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    ),
    ThemeItem(
      text: 'タンスの角に小指をぶつけたショックで',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    ),
    ThemeItem(
      text: 'お寿司のわさびがツーンとしすぎて',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    ),
    ThemeItem(
      text: '「UNO」を言い忘れて',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    ),
    ThemeItem(
      text: 'ブルースクリーンになって',
      imageUrl: 'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
    ),
    ThemeItem(
      text: 'リア充の爆発に巻き込まれて',
      imageUrl: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c',
    ),
    ThemeItem(
      text: '踊ってない夜を知って',
      imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    ),
    ThemeItem(
      text: 'パン食い競争でパンに食われて',
      imageUrl: 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99',
    ),
    ThemeItem(
      text: 'おばあちゃんの知恵袋を信じすぎて',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    ),
    ThemeItem(
      text: '空にあこがれて',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    ),
  ];

  // ランダムなお題を取得するメソッド
  static ThemeItem getRandomTheme() {
    final random = DateTime.now().millisecondsSinceEpoch % themes.length;
    return themes[random];
  }

  // インデックスでお題を取得するメソッド
  static ThemeItem getThemeAt(int index) {
    if (index >= 0 && index < themes.length) {
      return themes[index];
    }
    return themes[0]; // 範囲外の場合は最初のお題を返す
  }

  // お題の総数を取得
  static int get themeCount => themes.length;
}
