import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naturehike/controller/peminjam_controller.dart';
import 'package:naturehike/view/peminjam.dart';

class DetailPeminjam extends StatefulWidget {
  const DetailPeminjam({
    Key? key,
    this.id,
    this.bfnamapeminjam,
    this.bfalamat,
    this.bfselectbarang,
    this.bfjumlah,
    this.bfstatus,
  }) : super(key: key);

  final String? id;
  final String? bfnamapeminjam;
  final String? bfalamat;
  final String? bfselectbarang;
  final int? bfjumlah;
  final String? bfstatus;

  @override
  State<DetailPeminjam> createState() => _DetailPeminjamState();
}

class _DetailPeminjamState extends State<DetailPeminjam> {
  var peminjamController = PeminjamController();
  final formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  late String newstatus;
  List<String> statusOptions = [
    'Menunggu..',
    'Barang Sudah Dikembalikan',
    'Barang Hilang',
  ];

  @override
  void initState() {
    newstatus = widget.bfstatus ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Mengatur rata kiri
            children: [
              Image.asset(
                'assets/images/backpack.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color.fromARGB(112, 76, 175, 79),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Nama Peminjam: ${widget.bfnamapeminjam ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 4,
                color: Color.fromARGB(255, 150, 150, 150),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color.fromARGB(112, 76, 175, 79),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Alamat: ${widget.bfalamat ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 4,
                color: Color.fromARGB(255, 150, 150, 150),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color.fromARGB(112, 76, 175, 79),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Barang yang Dipinjam: ${widget.bfselectbarang ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 4,
                color: Color.fromARGB(255, 150, 150, 150),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color.fromARGB(112, 76, 175, 79),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Jumlah: ${widget.bfjumlah ?? 0}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 4,
                color: Color.fromARGB(255, 150, 150, 150),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(hintText: 'Status Barang'),
                  value: newstatus,
                  items: statusOptions.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      newstatus = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih status barang';
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft, // Mengatur rata kiri
                child: ElevatedButton(
                  onPressed: () {
                    // Panggil fungsi untuk menyimpan perubahan status barang
                    saveStatus();
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveStatus() {
    if (formkey.currentState!.validate()) {
      // Lakukan penyimpanan perubahan status barang ke database
      peminjamController.updateStatus(widget.id, newstatus);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status Barang telah diperbarui')),
      );

      // Kembali ke halaman Peminjam
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Peminjam(),
        ),
      );
    }
  }
}
