import 'package:flutter/material.dart';
import 'package:my_posyandu/db/db_helper.dart';
import 'package:my_posyandu/model/posyandu.dart';

class FormPosyandu extends StatefulWidget {
  final Posyandu? posyandu;

  FormPosyandu({this.posyandu});

  @override
  _FormPosyanduState createState() => _FormPosyanduState();
}

class _FormPosyanduState extends State<FormPosyandu> {
  DBHelper db = DBHelper();

  TextEditingController? nama;
  TextEditingController? ttl;
  TextEditingController? alamat;
  TextEditingController? keterangan;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.posyandu == null ? '' : widget.posyandu!.nama);
    ttl = TextEditingController(
        text: widget.posyandu == null ? '' : widget.posyandu!.ttl);
    alamat = TextEditingController(
        text: widget.posyandu == null ? '' : widget.posyandu!.alamat);
    keterangan = TextEditingController(
        text: widget.posyandu == null ? '' : widget.posyandu!.keterangan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY POSYANDU'),
        actions: [
          IconButton(
            onPressed: () {
              upsertPosyandu();
            },
            icon: Icon(Icons.save),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 235, 132, 178),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Column(children: [
                  TextFormField(
                    controller: nama,
                    decoration: InputDecoration(hintText: 'Nama'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ttl,
                    decoration: InputDecoration(hintText: 'Ttl'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: alamat,
                    decoration: InputDecoration(hintText: 'Alamat'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: keterangan,
                    decoration: InputDecoration(hintText: 'Keterangan'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          )),
    );
  }

  //update insert notes
  Future<void> upsertPosyandu() async {
    if (widget.posyandu != null) {
      //insert
      await db.updatePosyandu(Posyandu.fromMap({
        'id': widget.posyandu!.id,
        'nama': nama!.text,
        'ttl': ttl!.text,
        'alamat': alamat!.text,
        'keterangan': keterangan!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //update
      await db.savePosyandu(Posyandu(
        nama: nama!.text,
        ttl: ttl!.text,
        alamat: alamat!.text,
        keterangan: keterangan!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}