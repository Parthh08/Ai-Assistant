import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ai_assistant/global.dart';

class Apis {
  static late final GenerativeModel model;
  static late final ChatSession chat;

  static init() {
    model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
    chat = model.startChat();
  }

  static Future<String?> getAnswer(String question) async {
    print(question);
    try {
      // final content = [Content.text(question)];
      final response = await chat.sendMessage(Content.text(
        question,
      ));

      // Printing response in log
      print('res: ${response.text}');

      return response.text;
    } catch (e) {
      print(e);
      return 'Something went wrong';
    }
  }
}
