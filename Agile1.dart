import 'package:flutter/material.dart';

class MyIntro extends StatefulWidget {
  const MyIntro({super.key});

  @override
  State<MyIntro> createState() => _MyIntroState();
}

class _MyIntroState extends State<MyIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://img.freepik.com/premium-vector/monitor-vector_122446-20.jpg?w=826"),
              Text("Selamat Datang", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 40)),
            ],
          ),
        ),
      ),
    );
  }
}