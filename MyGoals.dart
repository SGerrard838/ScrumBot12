import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyAddGoals.dart';
import 'package:flutter_application_3/MyEditGoals.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Goal {
  final String id;
  String title;
  String description;

  Goal({required this.id, required this.title, required this.description});
}

class MyGoals extends StatefulWidget {
  const MyGoals({super.key});

  @override
  State<MyGoals> createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  List<Goal> goals = [];
  Goal? removedGoal;

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: goals.isEmpty ? _buildEmptyGoalsView() : _buildGoalsListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToAddGoalsPage();
        },
      ),
    );
  }

  Widget _buildEmptyGoalsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt_outlined, size: 48),
          SizedBox(height: 16.0),
          Text(
            'Belum ada Goals yang ditambahkan',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsListView() {
    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(goals[index].id),
          onDismissed: (direction) {
            setState(() {
              removedGoal = goals.removeAt(index);
            });
            _showUndoDeleteToast(context, goals[index], index);
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
          ),
          child: Card(
            child: ListTile(
              title: Text(goals[index].title),
              subtitle: Text(goals[index].description),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _navigateToEditGoalsPage(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToAddGoalsPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyAddGoals()),
    );
    if (result != null) {
      setState(() {
        String title = result['title'];
        String description = result['description'];
        goals.add(Goal(
          id: DateTime.now().toString(),
          title: title,
          description: description,
        ));
      });
      _showToast('Goal Berhasil Ditambahkan');
    }
  }

  void _navigateToEditGoalsPage(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyEditGoals(
          title: goals[index].title,
          description: goals[index].description,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        String title = result['title'];
        String description = result['description'];
        goals[index].title = title;
        goals[index].description = description;
      });
      _showToast('Goal Berhasil Diedit');
    }
  }

  // void _showSnackbar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 5),
  //     ),
  //   );
  // }

  void _showUndoDeleteToast(BuildContext context, Goal goal, int index) {
    Fluttertoast.showToast(
      msg: 'Goal Berhasil Dihapus',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
  }
}
