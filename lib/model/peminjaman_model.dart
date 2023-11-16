import 'dart:convert';

class PeminjamanBarangModel {
  String? id;
  String? namapeminjam;
  String? alamat;
  String? barangpinjam;
  int? jumlah;
  String? status;
  String? uid;
  PeminjamanBarangModel({
    this.id,
    this.namapeminjam,
    this.alamat,
    this.barangpinjam,
    this.jumlah,
    this.status,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namapeminjam': namapeminjam,
      'alamat': alamat,
      'barangpinjam': barangpinjam,
      'jumlah': jumlah,
      'status': status,
      'uid': uid,
    };
  }

  factory PeminjamanBarangModel.fromMap(Map<String, dynamic> map) {
    return PeminjamanBarangModel(
      id: map['id'],
      namapeminjam: map['namapeminjam'],
      alamat: map['alamat'],
      barangpinjam: map['barangpinjam'],
      jumlah: map['jumlah']?.toInt(),
      status: map['status'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PeminjamanBarangModel.fromJson(String source) => PeminjamanBarangModel.fromMap(json.decode(source));
}
