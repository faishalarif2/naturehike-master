import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naturehike/model/peminjaman_model.dart';

class PeminjamController {
  final CollectionReference peminjamCollection =
      FirebaseFirestore.instance.collection('peminjam');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addPeminjaman(PeminjamanBarangModel peminjaman) async {
    final pm = peminjaman.toMap();

    final DocumentReference docRef = await peminjamCollection.add(pm);

    final String docId = docRef.id;

    final PeminjamanBarangModel pbm = PeminjamanBarangModel(
      id: docId,
      namapeminjam: peminjaman.namapeminjam,
      alamat: peminjaman.alamat,
      barangpinjam: peminjaman.barangpinjam,
      jumlah: peminjaman.jumlah,
      status: peminjaman.status,
      uid: peminjaman.uid,
    );

    await docRef.update(pbm.toMap());
    await getPeminjam();
  }

  Future<List<DocumentSnapshot>> getPeminjam() async {
    final peminjam = await peminjamCollection.get();
    streamController.add(peminjam.docs);

    return peminjam.docs;
  }

  // Fungsi untuk memperbarui status peminjaman berdasarkan ID
  Future<void> updateStatus(String? id, String newStatus) async {
    try {
      await peminjamCollection.doc(id).update({
        'status': newStatus,
      });
      print(
          'Status peminjaman berhasil diperbarui: ID $id, Status: $newStatus');
    } catch (e) {
      print('Error saat memperbarui status peminjaman: $e');
    }
  }

  Future<void> deletePeminjaman(String peminjamanId) async {
    try {
      await peminjamCollection.doc(peminjamanId).delete();
      print('Data peminjaman berhasil dihapus: $peminjamanId');
    } catch (e) {
      print('Error saat menghapus data peminjaman: $e');
    }
  }
}
