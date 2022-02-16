class TableNameMo {
  List<TableMo>? data;

  TableNameMo({this.data});

  TableNameMo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TableMo>[];
      json['data'].forEach((v) {
        data!.add(TableMo.fromJson(v));
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

class TableMo {
  String? tableName;

  TableMo({this.tableName});

  TableMo.fromJson(Map<String, dynamic> json) {
    tableName = json['table_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['table_name'] = tableName;
    return data;
  }
}
