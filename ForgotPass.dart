import 'package:flutter/material.dart';

class MyForgetPass extends StatefulWidget {
  const MyForgetPass({super.key});

  @override
  State<MyForgetPass> createState() => _MyForgetPassState();
}

class _MyForgetPassState extends State<MyForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Lupa Kata Sandi", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    prefixIcon: Icon(Icons.mail, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Masukkan Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.green.shade50)
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    
                  });
                },
                child: Text("Berikutnya"),
              ),
            ]
          ),
        ),
      ), 
    );
  }
}