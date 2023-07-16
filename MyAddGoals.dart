import 'package:flutter/material.dart';

class Goal {
  final String id;
  String title;
  String description;

  Goal({required this.id, required this.title, required this.description});
}

class MyAddGoals extends StatefulWidget {
  const MyAddGoals({super.key});

  @override
  State<MyAddGoals> createState() => _MyAddGoalsState();
}

class _MyAddGoalsState extends State<MyAddGoals> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Goals"),
        actions: [
          TextButton(
            onPressed: (){
              String title = _titleController.text;
              String description = _descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                Navigator.pop(context, {
                    'title': title,
                    'description': description,
                  });
                } else {
                  _showSnackbar(context, 'Tolong isikan field kosong.');
                }
            }, 
            child: Text("Simpan", style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              maxLines: null,
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ],
        ),
      ),
    );
  }
}