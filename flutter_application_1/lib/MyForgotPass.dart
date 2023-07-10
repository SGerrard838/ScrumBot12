import 'package:flutter/material.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:flutter_application_3/MyOtp.dart';
import 'package:provider/provider.dart';

class MyForgetPass extends StatefulWidget {
  const MyForgetPass({super.key});

  @override
  State<MyForgetPass> createState() => _MyForgetPassState();
}

class _MyForgetPassState extends State<MyForgetPass> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderForgetPass>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: 310,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Lupa Kata Sandi", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: prov.tfemail2,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: prov.isEmailEmpty2? "Email Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    prefixIcon: const Icon(Icons.mail, color: Colors.green),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      prov.setEmailEmpty2 = prov.tfemail2.text.isEmpty;
                    });
                    if(!prov.isEmailEmpty2){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOtp()));
                    }
                  },
                  child: const Text("Berikutnya"),
                ),
              ),
            ]
          ),
        ),
      ), 
    );
  }
}