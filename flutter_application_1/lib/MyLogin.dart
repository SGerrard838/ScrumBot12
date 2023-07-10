import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyHome.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';
import 'package:flutter_application_3/MyRegister.dart';
import 'package:flutter_application_3/MyForgotPass.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderLogin>(context);
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Masuk", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: prov.tfemail,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: prov.isEmailEmpty? "Email Wajib Diisi" : null,
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: _obscurePassword,
                  controller: prov.tfpass,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
                    ),
                    errorText: prov.isPassEmpty? "Password Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Masukkan Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.green.shade50)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      prov.setEmailEmpty = prov.tfemail.text.isEmpty;
                      prov.setPassEmpty = prov.tfpass.text.isEmpty;
                    });
                    if(!prov.isEmailEmpty && !prov.isPassEmpty){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyForgetPass()));
                        }, 
                        child: const Text("Lupa Kata Sandi", style: TextStyle(color: Colors.green))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text("Belum Punya Akun?"),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRegister()));
                            }, 
                            child: const Text("Daftar sekarang", style: TextStyle(color: Colors.green))
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }
}