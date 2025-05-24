import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider {
  static List<String> imageUrls = [];

  // Goサーバーからデータを取得
  static Future<void> fetchImageUrls() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.179.17:8080/image-urls'));
      if (response.statusCode == 200) {
        imageUrls = List<String>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to load image URLs');
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }
}
