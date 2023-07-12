import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyAboutUs.dart';
import 'package:flutter_application_3/MyOldPass.dart';
import 'package:flutter_application_3/MyRating.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<SwitchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: 4,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: prov.enabledark,
                onChanged: (value) {
                  setState(() {
                    prov.enabledark = value;
                  });
                },
              ),
            );
          } else if (index == 1) {
            return ListTile(
              title: const Text("Ubah Kata Sandi"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOldPass()));
              },
            );
          } else if (index == 2) {
            return ListTile(
              title: const Text("Beri Ulasan"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRating()));
              },
            );
          } else if (index == 3) {
            return ListTile(
              title: const Text("Tentang Kami"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAboutUs()));
              },
            );
          }
          return null;
        },
      ),
    );
  }
}