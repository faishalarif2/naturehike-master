import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naturehike/controller/auth_controller.dart';
import 'package:naturehike/controller/barang_controller.dart';
import 'package:naturehike/view/barang_Form_view.dart';
import 'package:naturehike/view/detailbarang.dart';
import 'package:naturehike/view/updatebarang.dart';

import '../controller/barang_controller.dart';

class Barang extends StatefulWidget {
  const Barang({Key? key}) : super(key: key);

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  var cc = BarangController();
  final authController = AuthController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    cc.getBarang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List barang"),
      ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'List Barang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
            stream: cc.stream,
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
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Card(
                          elevation: 8,
                          child: ListTile(
                            leading: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                image: data[index]['imageUrl'] != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            data[index]['imageUrl']),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: data[index]['imageUrl'] == null
                                  ? Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : null,
                            ),
                            title: Text(data[index]['name']),
                            subtitle: Text(data[index]['jumlah'].toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateBarang(
                                          id: data[index]['id'],
                                          bfnama: data[index]['name'],
                                          bfjumlah: data[index]['jumlah'],
                                          bfdetail: data[index]['detail'],
                                          bfgambar: data[index]['imageUrl'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    cc.deleteContact(
                                      data[index]['id'].toString(),
                                    );
                                    setState(() {
                                      cc.getBarang();
                                    });
                                  },
                                ),
                              ],
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
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BarangFormView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
