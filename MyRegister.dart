import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyHome.dart';
import 'package:flutter_application_3/MyLogin.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_3/Provider.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderRegister>(context);
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
                child: Text("Daftar", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: prov.tfname,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorText: prov.isNameEmpty? "Nama Lengkap Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Masukkan Nama Lengkap',
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
                  controller: prov.tfusername,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorText: prov.isUsernameEmpty? "Username Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade50),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Masukkan Username',
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
                  controller: prov.tfemail1,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: prov.isEmailEmpty1? "Email wajib Diisi" : null,
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
                  controller: prov.tfpass1,
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
                    errorText: prov.isPassEmpty1? "Password Wajib Diisi" : null,
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
                      prov.setNameEmpty = prov.tfname.text.isEmpty;
                      prov.setUsernameEmpty = prov.tfusername.text.isEmpty;
                      prov.setEmailEmpty1 = prov.tfemail1.text.isEmpty;
                      prov.setPassEmpty1 = prov.tfpass1.text.isEmpty;
                    });
                    if(!prov.isNameEmpty && !prov.isUsernameEmpty && !prov.isEmailEmpty1 && !prov.isPassEmpty1){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
                    }
                  },
                  child: const Text("Daftar"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    const Text("Sudah Punya akun?"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLogin()));
                        }, 
                        child: const Text("Login", style: TextStyle(color: Colors.green))
                      ),
                    )
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