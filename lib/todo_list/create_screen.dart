import 'package:flutter/material.dart';
import '../main.dart';
import 'todo.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할일 작성'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              await todos.add(
                Todo(
                  title: _textController.text,
                  dateTime: DateTime.now().millisecondsSinceEpoch,
                ),
              );
              if (mounted) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintStyle: TextStyle(color: Colors.grey.shade500),
            hintText: '할일을 입력하세요!',
            filled: true,
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }
}
