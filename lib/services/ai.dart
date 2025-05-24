// filepath: d:\Development\jogi_hackathon\lib\services\gemini_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiApiService {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final String endpoint =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent';

  Future<List<Map<String, dynamic>>> evaluateHumor(
      List<Map<String, String>> data) async {
    // プロンプト生成
    final promptBuffer = StringBuffer();
    promptBuffer.writeln('次の死因と遺言を見て、それぞれが本当に面白いかどうかを厳しく評価してください。');
    promptBuffer.writeln('「面白い」と判断できるのは以下のいずれかに該当する場合のみです：');
    promptBuffer.writeln('- 強い意外性、矛盾、皮肉、ブラックユーモアがある');
    promptBuffer.writeln('- 思わず笑ってしまうような明確な仕掛けや言葉遊びがある');
    promptBuffer.writeln('- 文脈や文化背景に基づいたユーモアがあり、明確な理由で笑える');
    promptBuffer.writeln('※ 単に少し変わっている、シュールである、程度では「面白い」と判定しないでください。');
    promptBuffer.writeln('※ ほとんどの例は面白くない可能性が高いという前提で評価してください。');
    promptBuffer.writeln('以下のJSON形式で答えてください：');
    promptBuffer.writeln(
        '[{"死因": "XXX", "遺言": "YYY", "面白い": true|false, "理由": "ZZZ"}, ...]');
    promptBuffer.writeln('データ:');
    for (int i = 0; i < data.length; i++) {
      promptBuffer
          .writeln('${i + 1}. 死因: ${data[i]["cause"]}, 遺言: ${data[i]["will"]}');
    }

    final prompt = promptBuffer.toString();

    final uri = Uri.parse('$endpoint?key=$apiKey');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);

        final rawText = jsonResponse['candidates'][0]['content']['parts'][0]
            ['text'] as String;

        final cleanedText = removeCodeBlock(rawText);
        print('Cleaned Text: $cleanedText'); // クリーンアップ後ログ

        final jsonResult = jsonDecode(cleanedText); // パース実施
        return List<Map<String, dynamic>>.from(jsonResult);
      } catch (e) {
        print('JSON Parse Error: $e'); // パースエラーをログに出力
        throw Exception('JSON Parse Error: $e');
      }
    } else {
      print('API Error Response: ${response.body}'); // エラーレスポンスをログに出力
      throw Exception(
          'Gemini API Error: ${response.statusCode} ${response.body}');
    }
  }

  String removeCodeBlock(String text) {
    final codeBlockReg = RegExp(r'^```json\s*|```$', multiLine: true);
    return text.replaceAll(codeBlockReg, '').trim();
  }

  /// 利用可能なモデル一覧を取得して表示
  Future<void> listAvailableModels() async {
    final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1/models?key=$apiKey');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('--- 利用可能なモデル一覧 ---');
      for (var model in jsonResponse['models']) {
        print('・${model['name']}');
      }
    } else {
      throw Exception(
          'モデル一覧の取得に失敗しました: ${response.statusCode} ${response.body}');
    }
  }
}
