import 'package:flutter/material.dart';
import 'package:my_posyandu/model/posyandu.dart';

class DetailPosyanduPage extends StatelessWidget {
  final Posyandu? posyandu;

  DetailPosyanduPage(this.posyandu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MY POSYANDU'),
          backgroundColor: Color.fromARGB(255, 247, 121, 175),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(31, 247, 172, 219),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nama',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${posyandu!.nama}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ttl',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${posyandu!.ttl}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Alamat',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${posyandu!.alamat}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Keterangan',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${posyandu!.keterangan}'),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}