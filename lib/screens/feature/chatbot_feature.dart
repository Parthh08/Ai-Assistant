import 'package:ai_assistant/controller/chat_controller.dart';
import 'package:ai_assistant/global.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:ai_assistant/widget/message_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  final _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chatBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey.shade800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade200, width: 2),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/assistant.png',
                  width: 22,
                  height: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Always here to help',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline_rounded, color: Colors.grey.shade700),
            onPressed: () {
              if (_c.chatList.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text('Clear Chat'),
                    content: const Text('Are you sure you want to clear all messages?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _c.chatList.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => _c.chatList.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                controller: _c.ScrollC,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 12, bottom: 100),
                itemCount: _c.chatList.length,
                itemBuilder: (context, index) {
                  return MessageCard(message: _c.chatList[index]);
                },
              ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: _c.chatInputController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _c.askQuestion();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade500, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _c.askQuestion,
                      customBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade100, width: 3),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/assistant.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Hi! I\'m your AI Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Ask me anything and I\'ll do my best to help you!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildSuggestionChip(
              icon: Icons.lightbulb_outline_rounded,
              label: 'Get creative ideas',
            ),
            const SizedBox(height: 12),
            _buildSuggestionChip(
              icon: Icons.code_rounded,
              label: 'Help with coding',
            ),
            const SizedBox(height: 12),
            _buildSuggestionChip(
              icon: Icons.psychology_outlined,
              label: 'Answer questions',
            ),
            const SizedBox(height: 12),
            _buildSuggestionChip(
              icon: Icons.edit_note_rounded,
              label: 'Write content',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue.shade600, size: 22),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
