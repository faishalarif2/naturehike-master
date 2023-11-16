import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturehike/controller/barang_controller.dart';
import 'package:naturehike/model/barang_model.dart';
import 'package:naturehike/view/barang.dart';

class BarangFormView extends StatefulWidget {
  const BarangFormView({Key? key}) : super(key: key);

  @override
  State<BarangFormView> createState() => _BarangFormViewState();
}

class _BarangFormViewState extends State<BarangFormView> {
  var barangController = BarangController();
  final formKey = GlobalKey<FormState>();
  String? name;
  int? jumlah;
  String? detail;
  File? imageFile;
  final user = FirebaseAuth.instance.currentUser!;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: imageFile != null
                          ? Image.file(imageFile!)
                          : Placeholder(),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                    ),
                    onPressed: () {
                      getImage();
                    },
                    child: Text('Select Image'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Nama Alat'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Jumlah Alat'),
                    onChanged: (value) {
                      jumlah = int.tryParse(value);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Detail Alat'),
                    onChanged: (value) {
                      detail = value;
                    },
                  ),
                  ElevatedButton(
                    child: Text('Add Barang'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BarangModel bm = BarangModel(
                            name: name!, jumlah: jumlah!, detail: detail!,uid: user.uid);
                        barangController.addBarang(bm, imageFile!);
    
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Barang(),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
