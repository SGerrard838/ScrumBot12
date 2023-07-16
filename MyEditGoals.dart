import 'package:flutter/material.dart';

class MyEditGoals extends StatefulWidget {
  final String title;
  final String description;
  const MyEditGoals({super.key, required this.title, required this.description});

  @override
  State<MyEditGoals> createState() => _MyEditGoalsState();
}

class _MyEditGoalsState extends State<MyEditGoals> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Goal'),
        actions: [
          TextButton(
              child: Text('Simpan', style: TextStyle(color: Colors.white)),
              onPressed: () {
                String title = _titleController.text;
                String description = _descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  Navigator.pop(context, {
                    'title': title,
                    'description': description,
                  });
                } else {
                  _showSnackbar(context, 'Tolong isikan field kosong');
                }
              },
            ),
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

  void _showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 2),
      ),
    );
  }
}