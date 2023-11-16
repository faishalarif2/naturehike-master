import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

import 'package:naturehike/controller/barang_controller.dart';

import '../model/barang_model.dart';

class UpdateBarang extends StatefulWidget {
  const UpdateBarang({
    Key? key,
    this.id,
    this.bfnama,
    this.bfjumlah,
    this.bfdetail,
    this.bfgambar,

  }) : super(key: key);

  final String? id;
  final String? bfnama;
  final int? bfjumlah;
  final String? bfdetail;
  final String? bfgambar;


  @override
  State<UpdateBarang> createState() => _UpdateBarangState();
}

class _UpdateBarangState extends State<UpdateBarang> {
  var barangController = BarangController();
  final formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  String? newname;
  int? newjumlah;
  String? newdetail;
  File? newgambar;
  String? nwgambar;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        newgambar = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    newname = widget.bfnama;
    newjumlah = widget.bfjumlah;
    newdetail = widget.bfdetail;
    nwgambar = widget.bfgambar; // Inisialisasi newgambar dengan widget.bfgambar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Barang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: newgambar != null
                        ? Image.file(newgambar!)
                        : widget.bfgambar != null
                            ? Image.network(widget.bfgambar!)
                            : const Placeholder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Select Image'),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nama Barang'),
                  onChanged: (value) {
                    newname = value;
                  },
                  initialValue: widget.bfnama,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Jumlah'),
                  onChanged: (value) {
                    newjumlah = int.tryParse(value);
                  },
                  initialValue: widget.bfjumlah.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Detail'),
                  onChanged: (value) {
                    newdetail = value;
                  },
                  initialValue: widget.bfdetail,
                ),
                ElevatedButton(
                  child: Text('Update Barang'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BarangModel barangModel = BarangModel(
                        name: newname,
                        uid: user.uid,
                        jumlah: newjumlah,
                        detail: newdetail,
                        imageUrl: newgambar != null ? newgambar!.path : widget.bfgambar,
                      );
                      await barangController.updateBarang(
                        widget.id!,
                        barangModel,
                        newgambar,
                      );

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
