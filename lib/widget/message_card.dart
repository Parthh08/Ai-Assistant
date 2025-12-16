import 'package:ai_assistant/model/message.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return message.msgType == MessageType.bot
        ? _buildBotMessage(context)
        : _buildUserMessage(context);
  }

  Widget _buildBotMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.shade200, width: 2),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/assistant.png',
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade50,
                        Colors.blue.shade50.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    border: Border.all(color: Colors.blue.shade100, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: message.msg.isEmpty
                      ? AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Thinking...',
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          repeatForever: true,
                          pause: const Duration(milliseconds: 500),
                        )
                      : MarkdownBody(
                          data: message.msg,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            code: TextStyle(
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.red.shade700,
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                            codeblockDecoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            codeblockPadding: const EdgeInsets.all(12),
                            blockquote: TextStyle(
                              color: Colors.grey.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                            blockquoteDecoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                              border: Border(
                                left: BorderSide(
                                  color: Colors.blue.shade300,
                                  width: 4,
                                ),
                              ),
                            ),
                            h1: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            h2: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            h3: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            listBullet: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                ),
                if (message.msg.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => _copyToClipboard(context, message.msg),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Copy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.msg,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
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
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
