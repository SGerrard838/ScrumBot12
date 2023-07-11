import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyForgetPassChange.dart';
import 'package:flutter_application_3/MyNewPassChange.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MyOldPass extends StatefulWidget {
  const MyOldPass({super.key});

  @override
  State<MyOldPass> createState() => _MyOldPassState();
}

class _MyOldPassState extends State<MyOldPass> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderOldPass>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kata Sandi Lama"),
        actions: [
          TextButton(
            onPressed: (){
              setState(() {
                prov.setPassEmpty1 = prov.tfpass1.text.isEmpty;
              });
                if(!prov.isPassEmpty1){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyNewPassChange()));
                  prov.tfpass1.clear();
                }
            }, 
            child: const Text('Selesai', style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              obscureText: _obscurePassword,
              controller: prov.tfpass1,
              cursorColor: Colors.green,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Kata Sandi Lama',
                errorText: prov.isPassEmpty1? "Kata Sandi Wajib Diisi" : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyForgetPassChange()));
                  prov.tfpass1.clear();
                }, 
                child: const Text("Lupa Kata Sandi", style: TextStyle(color: Colors.green),)
              ),
            )
          ],
        ),
      ),
    );
  }
}