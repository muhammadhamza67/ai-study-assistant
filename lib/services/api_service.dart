import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<String> sendPrompt({
    required String type,
    required String input,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/generate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "type": type,
        "input": input,
      }),
    );

    final data = jsonDecode(response.body);
    return data["response"];
  }
}