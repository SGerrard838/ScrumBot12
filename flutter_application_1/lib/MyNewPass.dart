import 'package:flutter/material.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_3/MyHome.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyNewPass extends StatefulWidget {
  const MyNewPass({super.key});

  @override
  State<MyNewPass> createState() => _MyNewPassState();
}

class _MyNewPassState extends State<MyNewPass> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderNewPass>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
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
                padding: EdgeInsets.all(8.0),
                child: Text("Masukkkan Kata Sandi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: _obscurePassword,
                  controller: prov.tfpass1,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.green,
                      ),
                    ),
                    errorText:
                        prov.isPassEmpty1 ? "Password Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade50),
                        borderRadius: BorderRadius.circular(40)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade50),
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Masukkan Kata Sandi Baru',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.green.shade50)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: _obscureConfirmPassword,
                  controller: prov.tfpass2,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.green,
                      ),
                    ),
                    errorText:
                        prov.isPassEmpty2 ? "Password Wajib Diisi" : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade50),
                        borderRadius: BorderRadius.circular(40)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade50),
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    hintText: 'Konfirmasi Kata Sandi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.green.shade50)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      prov.setPassEmpty1 = prov.tfpass1.text.isEmpty;
                      prov.setPassEmpty2 = prov.tfpass2.text.isEmpty;
                    });
                    if (!prov.isPassEmpty1 && !prov.isPassEmpty2) {
                      if (prov.tfpass1.text == prov.tfpass2.text) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const MyHome()));
                      } else {
                        Fluttertoast.showToast(
                          msg: "Kata Sandi tidak cocok",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white
                        );
                      }
                    }
                  },
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
