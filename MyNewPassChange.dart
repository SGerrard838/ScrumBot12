import 'package:flutter/material.dart';
import 'package:flutter_application_3/MySetting.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyNewPassChange extends StatefulWidget {
  const MyNewPassChange({super.key});

  @override
  State<MyNewPassChange> createState() => _MyNewPassChangeState();
}

class _MyNewPassChangeState extends State<MyNewPassChange> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderChangeNewPass>(context);

    void _showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Baru'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  prov.setPassEmpty1 = prov.tfpass1.text.isEmpty;
                  prov.setPassEmpty2 = prov.tfpass2.text.isEmpty;
                });
                if (!prov.isPassEmpty1 && !prov.isPassEmpty2) {
                  if (prov.tfpass1.text == prov.tfpass2.text) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MySetting()));
                    prov.tfpass1.clear(); // Mengosongkan nilai text field
                    prov.tfpass2.clear();
                    _showSnackBar("Kata sandi berhasil diubah");
                  } else {
                    Fluttertoast.showToast(
                        msg: "Kata Sandi tidak cocok",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white);
                  }
                }
              },
              child: const Text('Selesai', style: TextStyle(color: Colors.white)))
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
                labelText: 'Password Baru',
                errorText: prov.isPassEmpty1 ? "Password Wajib Diisi" : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: _obscureConfirmPassword,
              controller: prov.tfpass2,
              cursorColor: Colors.green,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password Baru',
                errorText: prov.isPassEmpty2 ? "Password Wajib Diisi" : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
