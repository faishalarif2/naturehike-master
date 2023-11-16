import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/controller/barang_controller.dart';
import 'package:naturehike/controller/peminjam_controller.dart';
import 'package:naturehike/view/detailpeminjaman.dart';
import 'package:naturehike/view/peminjamanview.dart';

class Peminjam extends StatefulWidget {
  const Peminjam({Key? key}) : super(key: key);

  @override
  State<Peminjam> createState() => _PeminjamState();
}

class _PeminjamState extends State<Peminjam> {
  var ct = PeminjamController();
  var cc = BarangController();
  final authController = AuthController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    ct.getPeminjam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Peminjam"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'List Data Peminjam',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Toko NatureHike',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: ct.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<DocumentSnapshot> data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data[index]['uid'] == user.uid) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPeminjam(
                                    id: data[index]['id'],
                                    bfnamapeminjam: data[index]['namapeminjam'],
                                    bfalamat: data[index]['alamat'],
                                    bfjumlah: data[index]['jumlah'],
                                    bfselectbarang: data[index]['barangpinjam'],
                                    bfstatus: data[index]['status'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: getColorByStatus(data[index]['status']),
                              child: ListTile(
                                title: Text(data[index]['namapeminjam']),
                                subtitle: Text(data[index]['status']),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    ct.deletePeminjaman(
                                      data[index]['id'].toString(),
                                    );
                                    setState(() {
                                      ct.getPeminjam();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PeminjamanView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getColorByStatus(String status) {
    switch (status) {
      case 'Menunggu..':
        return Colors.yellow;
      case 'Barang Sudah Dikembalikan':
        return Colors.green;
      case 'Barang Hilang':
        return Colors.red;
      case 'Sedang Dipinjam':
        return Colors.blue;
      default:
        return Colors.white;
    }
  }
}
