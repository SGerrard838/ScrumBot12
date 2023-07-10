import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyNewPassChange.dart';

class MyChangeOtpPage extends StatefulWidget {
  const MyChangeOtpPage({super.key});

  @override
  _MyChangeOtpPageState createState() => _MyChangeOtpPageState();
}

class _MyChangeOtpPageState extends State<MyChangeOtpPage> {
  String otpCode = '';

  bool get isOtpValid => otpCode.length == 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman OTP'),
        actions: [
          TextButton(
            onPressed: isOtpValid ? () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyNewPassChange()));
            } : null, 
            child: const Text('Selesai', style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  otpCode = value;
                });
              },
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Kode OTP',
              ),
            ),
          ],
        ),
      ),
    );
  }
}