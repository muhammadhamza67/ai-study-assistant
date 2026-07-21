import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PromptScreen extends StatefulWidget {
  final String type;

  const PromptScreen({super.key, required this.type});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, String>> messages = [];
  bool loading = false;

  void sendRequest() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": text});
      loading = true;
    });

    controller.clear();

    final result = await ApiService.sendPrompt(
      type: widget.type,
      input: text,
    );

    setState(() {
      messages.add({"role": "ai", "text": result});
      loading = false;
    });
  }

  Widget buildMessage(Map<String, String> msg) {
    bool isUser = msg["role"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.blueAccent
              : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg["text"] ?? "",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),

      appBar: AppBar(
        title: Text(widget.type.toUpperCase()),
        backgroundColor: const Color(0xFF203A43),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (loading ? 1 : 0),
              itemBuilder: (context, index) {
                if (loading && index == messages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "AI is thinking...",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                }

                return buildMessage(messages[index]);
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF203A43),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: sendRequest,
                  icon: const Icon(Icons.send, color: Color.fromARGB(255, 23, 16, 16)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}