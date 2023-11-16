import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/peminjam_controller.dart';
import 'package:naturehike/model/peminjaman_model.dart';
import 'package:naturehike/view/peminjam.dart';

import '../controller/auth_controller.dart';
import '../controller/barang_controller.dart';

class PeminjamanView extends StatefulWidget {
  const PeminjamanView({Key? key}) : super(key: key);

  @override
  State<PeminjamanView> createState() => _PeminjamanViewState();
}

class _PeminjamanViewState extends State<PeminjamanView> {
  var peminjamController = PeminjamController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  String? namapeminjam;
  String? alamat;
  String? selectedBarang;
  int? jumlah;
  String? status = 'Menunggu..';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peminjaman"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Peminjaman',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Peminjam',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Peminjam harus diisi';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      namapeminjam = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat harus diisi';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      alamat = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('barang')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return Text('No data available');
                    }
                    List<DropdownMenuItem<String>> barangItems = [];
                    final items = snapshot.data!.docs.reversed.toList();
                    barangItems.add(
                      DropdownMenuItem(
                        value: "0",
                        child: Text("Select Barang"),
                      ),
                    );
                    for (var item in items) {
                      barangItems.add(
                        DropdownMenuItem(
                          value: item['name'],
                          child: Text(item['name']),
                        ),
                      );
                    }
                    return DropdownButtonFormField<String>(
                      value: selectedBarang,
                      items: barangItems,
                      onChanged: (value) {
                        setState(() {
                          selectedBarang = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Nama Barang',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "0") {
                          return 'Nama Barang harus dipilih';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Jumlah',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah harus diisi';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      jumlah = int.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: status,
                  items: [
                    DropdownMenuItem(
                      value: 'Menunggu..',
                      child: Text('Menunggu..'),
                    ),
                    DropdownMenuItem(
                      value: 'Barang Sudah Dikembalikan',
                      child: Text('Barang Sudah Dikembalikan'),
                    ),
                    DropdownMenuItem(
                      value: 'Barang Hilang',
                      child: Text('Barang Hilang'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Status',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Status harus dipilih';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Form validation passed, submit data
                      PeminjamanBarangModel peminjaman = PeminjamanBarangModel(
                        namapeminjam: namapeminjam!,
                        uid: user.uid,
                        alamat: alamat!,
                        status: status,
                        barangpinjam: selectedBarang!,
                        jumlah: jumlah!,
                      );
                      peminjamController.addPeminjaman(peminjaman);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Peminjam(),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
