import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyIntro.dart';

class MyWelcome extends StatefulWidget {
  const MyWelcome({super.key});

  @override
  State<MyWelcome> createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyIntro()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://img.freepik.com/premium-vector/monitor-vector_122446-20.jpg?w=740", width: 200, height: 200,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("ScrumBlogger", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}