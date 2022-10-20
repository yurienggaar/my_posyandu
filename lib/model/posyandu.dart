class Posyandu {
  int? id;
  String? nama;
  String? ttl;
  String? alamat;
  String? keterangan;

  Posyandu({this.id, this.nama, this.ttl, this.alamat, this.keterangan});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['ttl'] = ttl;
    map['alamat'] = alamat;
    map['keterangan'] = keterangan;
    return map;
  }

  Posyandu.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.ttl = map['ttl'];
    this.alamat = map['alamat'];
    this.keterangan = map['keterangan'];
  }
}