import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyChangePassotp.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MyForgetPassChange extends StatefulWidget {
  const MyForgetPassChange({super.key});

  @override
  State<MyForgetPassChange> createState() => _MyForgetPassChangeState();
}

class _MyForgetPassChangeState extends State<MyForgetPassChange> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderForgetNewPass>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Kata Sandi"),
        actions: [
          TextButton(
            onPressed: (){
              setState(() {
                prov.setEmailEmpty1 = prov.tfemail1.text.isEmpty;
              });
                if(!prov.isEmailEmpty1){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyChangeOtpPage()));
                }
            }, 
            child: const Text('Lanjut', style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: prov.tfemail1,
              cursorColor: Colors.green,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Masukkan Email',
                errorText: prov.isEmailEmpty1? "Email Wajib Diisi" : null,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}