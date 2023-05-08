import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Verifikasi Kode')),
        body: Center(
            child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ENTER THE VERIFICATION CODE',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Container(
                      height: 10,
                    ),
                    Text('Enter the 6 digit verification code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    Container(
                      height: 20,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Verification Code',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        style: TextStyle(color: Colors.black)),
                    Container(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Send'),
                    )
                  ],
                ))));
  }
}
