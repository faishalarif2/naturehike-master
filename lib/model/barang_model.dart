import 'dart:convert';
import 'dart:io';

class BarangModel {
  String? id;
  String? name;
  int? jumlah;
  String? detail;
  String? imageUrl;
  String? uid;
  BarangModel({
    this.id,
    this.name,
    this.jumlah,
    this.detail,
    this.imageUrl,
    this.uid,
  });

  BarangModel copywith({
    String? id,
    String? name,
    int? jumlah,
    String? detail,
    String? imageUrl,
    String? uid,
  }) {
    return BarangModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jumlah: jumlah ?? this.jumlah,
      detail: detail ?? this.detail,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'jumlah': jumlah,
      'detail': detail,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }

  factory BarangModel.fromMap(Map<String, dynamic> map) {
    return BarangModel(
      id: map['id'],
      name: map['name'],
      jumlah: map['jumlah'],
      detail: map['detail'],
      imageUrl: map['imageUrl'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BarangModel.fromJson(String source) =>
      BarangModel.fromMap(json.decode(source));
}
