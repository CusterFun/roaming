class DBNameListMo {
  List<DBNameMo>? data;

  DBNameListMo({this.data});

  DBNameListMo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DBNameMo>[];
      json['data'].forEach((v) {
        data!.add(DBNameMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DBNameMo {
  String? database;

  DBNameMo({this.database});

  DBNameMo.fromJson(Map<String, dynamic> json) {
    database = json['database'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['database'] = database;
    return data;
  }
}
