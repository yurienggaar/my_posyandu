import 'package:flutter/material.dart';
import 'package:my_posyandu/db/db_helper.dart';
import 'package:my_posyandu/model/posyandu.dart';
import 'package:my_posyandu/ui/detail_posyandu.dart';
import 'package:my_posyandu/ui/form_posyandu.dart';

class ListPosyanduPage extends StatefulWidget {
  const ListPosyanduPage({Key? key}) : super(key: key);

  @override
  _ListPosyanduPageState createState() => _ListPosyanduPageState();
}

class _ListPosyanduPageState extends State<ListPosyanduPage> {
  List<Posyandu> listPosyandu = [];
  DBHelper db = DBHelper();

  @override
  void initState() {
    _getAllPosyandu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ui tampilan awal
    return Scaffold(
      appBar: AppBar(
        title: Text('MY POSYANDU'),
        backgroundColor: Color.fromARGB(255, 238, 128, 183),
      ),
      body: ListView.builder(
        itemCount: listPosyandu.length,
        itemBuilder: (context, index) {
          Posyandu posyandu = listPosyandu[index];
          return Container(
              child: Column(children: [
            ListTile(
              onTap: () {
                //edit
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPosyanduPage(posyandu),
                    ));
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                "${posyandu.nama}",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 224, 103, 141),
                ),
              ),
              //overflow: TextOverflow.ellipsis(pada text…)
              subtitle: Text(
                '${posyandu.alamat}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deletePosyandu(posyandu, index);
                },
                icon: Icon(Icons.delete),
              ),
              leading: IconButton(
                onPressed: () {
                  _openFormEdit(posyandu);
                },
                icon: Icon(Icons.edit),
              ),
            )
          ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 223, 106, 174),
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllPosyandu() async {
    var list = await db.getAllPosyandu();
    setState(() {
      listPosyandu.clear();
      list!.forEach((posyandu) {
        listPosyandu.add(Posyandu.fromMap(posyandu));
      });
    });
  }

  //form create
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormPosyandu()));
    if (result == 'save') {
      await _getAllPosyandu();
    }
  }

  Future<void> _deletePosyandu(Posyandu posyandu, int position) async {
    await db.deletePosyandu(posyandu.id!);

    setState(() {
      listPosyandu.removeAt(position);
    });
  }

  //form edit
  Future<void> _openFormEdit(Posyandu posyandu) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormPosyandu(posyandu: posyandu)));

    if (result == 'update') {
      await _getAllPosyandu();
    }
  }
}