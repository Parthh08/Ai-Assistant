import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final ScrollC = ScrollController();

  final chatList = <Message>[].obs;
  final chatInputController = TextEditingController();

  Future<void> askQuestion() async {
    final question = chatInputController.text.trim();
    if (question.isEmpty) return;

    // Clear input immediately
    chatInputController.clear();

    // Add user message
    chatList.add(Message(msg: question, msgType: MessageType.user));
    
    // Add loading message
    chatList.add(Message(msg: '', msgType: MessageType.bot));
    
    // Scroll after a small delay to ensure layout is updated
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollDown();

    // Get AI response
    final res = await Apis.getAnswer(question);
    
    // Remove loading message
    chatList.removeLast();
    
    // Add actual response
    chatList.add(Message(msg: res ?? 'Something went wrong', msgType: MessageType.bot));
    
    // Scroll to bottom again
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollDown();
  }

  void _scrollDown() {
    if (ScrollC.hasClients) {
      ScrollC.animateTo(
        ScrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
