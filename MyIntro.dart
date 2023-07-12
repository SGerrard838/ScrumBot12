import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyLogin.dart';
import 'package:flutter_application_3/MyRegister.dart';

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
        child: SizedBox(
          width: 310,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network("https://img.freepik.com/premium-vector/monitor-vector_122446-20.jpg?w=740", width: 250, height: 250,),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Selamat Datang", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 30), textAlign: TextAlign.center),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Jelajahi berbagai personal blogger terupdate untuk menemani hari anda",
                  style : TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      color: Colors.green
                    )
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRegister()));
                  }, 
                  child: const Text("Daftar", style: TextStyle(color: Colors.green))
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLogin()));
                  }, 
                  child: const Text("Masuk", style: TextStyle(color: Colors.white))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}