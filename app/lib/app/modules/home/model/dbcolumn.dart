class ColumnsMo {
  List<ColumnMo>? data;

  ColumnsMo({this.data});

  ColumnsMo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ColumnMo>[];
      json['data'].forEach((v) {
        data!.add(ColumnMo.fromJson(v));
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

class ColumnMo {
  String? columnComment;
  String? columnName;
  String? dataType;

  ColumnMo({this.columnComment, this.columnName, this.dataType});

  ColumnMo.fromJson(Map<String, dynamic> json) {
    columnComment = json['column_comment'];
    columnName = json['column_name'];
    dataType = json['data_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['column_comment'] = columnComment;
    data['column_name'] = columnName;
    data['data_type'] = dataType;
    return data;
  }
}
