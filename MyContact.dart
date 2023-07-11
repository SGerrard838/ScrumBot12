import 'package:flutter/material.dart';

class MyContactandFAQ extends StatefulWidget {
  const MyContactandFAQ({super.key});

  @override
  State<MyContactandFAQ> createState() => _MyContactandFAQState();
}

class _MyContactandFAQState extends State<MyContactandFAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kontak dan FAQ"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MyContact(),
            Divider(),
            MyFAQ()
          ]
        ),
      ),
    );
  }
}

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kontak',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('mediarelation@scrumblogger.com'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Nomor Telepon'),
            subtitle: Text('083672452354'),
          ),
        ],
      ),
    );
  }
}

class MyFAQ extends StatefulWidget {
  const MyFAQ({super.key});

  @override
  State<MyFAQ> createState() => _MyFAQState();
}

class _MyFAQState extends State<MyFAQ> {
  List<String> faqList = [
    'Saya Tidak Bisa Login atau Tidak Menerima Email Lupa Kata Sandi',
    'Saya ingin mengubah email saya untuk ScrumBlogger NewsLetter',
    'Saya ingin mengubah email yang terkait dengan akun ScrumBlogger',
    'Saya perlu menghubungi Tim Hubungan Media ScrumBlogger',
    'Tautan di email lupa kata sandi tidak berfungsi',
    'Saya terus keluar dari akun saya',
  ];
  List<String> AnsFAQ =[
    '''Jika Anda tidak dapat login dan Anda tidak menerina email lupa kata sandi, mungkin karena Anda belum memiliki akun ScrumBlogger di email anda.
                  
Anda dapat menggunakan email yang sama dengan Anda gunakan untuk mendaftar di ScrumBlogger untuk mendapatkan email lupa kata sandi.''',
'''Untuk mengubah email ScrumBlogger Newsletter, Anda harus berhenti berlangganan dari Newsletter dengan alamat email saat ini dan kemudian mendaftar dengan email yang baru.
                  
Anda dapat mengikuti langkah-langkah di bawah ini:
1. Buka Buletin terbaru yang diterima di email Anda saat ini (Alamat dimana Anda tidak lagi ingin menerima buletin).
2. Gulir ke bawah bagian bawah pesan dan klik berhenti berlangganan.
3. Sekarang Anda dapat mendaftar lagi dengan menavigasikan ke halaman buletin ScrumBlogger, lalu mendaftar buletin pilihan Anda dengan alamat email pilihan Anda.
''',
'''Anda dapat mengubah email akun Anda dengan mengikuti langkah-langkah di bawah ini:
1. Buka Scrumblogger.com, pilih Masuk yang berada di pojok kanan atas.
2. Ikuti perintah untuk memasukkan email dan kata sandi akun Anda saat ini.
3. Setelah berhasil masuk, klik My Account lalu klik Profil
4. Anda akan diarahkan ke halaman Profil Anda, dimana Anda dapat memperbarui informasi akun Anda.''',
'''Hanya untuk pertanyaan pers, hubungi Tim Hubungan Media ScrumBlogger di mediarelation@scrumblogger.com atau telepon ke 083672452354''',
'''Jika tautan email lupa kata sandi tidak berfungsi, silahkan coba beberapa saat lagi''',
'''Jika Anda berulang kali keluar dari akun, coba langkah-langkah di bawah ini:
1. Buka Web Anda
2. Dari atas menu, klik Preferensi
3. Dari sana, buka Privasi dan hapus centang pada kotak di samping "Cegah Pelacakan Lintas Situs"
4. Anda seharusnya dapat tetap masuk ke akun Anda sekarang, tetapi jika masih tidak berhasil, Anda mungkin perlu menghapus cookie Anda. Untuk melakukan itu, Anda cukup mengklik "Kelola Data Situs Web" dari halaman yang sama dan klik "Hapus Semua"'''
  ];
  List<String> filteredFaqList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredFaqList = faqList;
    super.initState();
  }

  void filterFaqs(String query) {
    List<String> filteredFaqs = [];
    for (var faq in faqList) {
      if (faq.toLowerCase().contains(query.toLowerCase())) {
        filteredFaqs.add(faq);
      }
    }
    setState(() {
      filteredFaqList = filteredFaqs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FAQ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: searchController,
            onChanged: (value) {
              filterFaqs(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cari',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: filteredFaqList.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(filteredFaqList[index]),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(AnsFAQ[index]),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}