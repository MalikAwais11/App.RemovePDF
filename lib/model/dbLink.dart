class DbModel {
  List<DbLink>? result;
  List<String>? errors;
  bool? success;

  DbModel({this.result, this.errors, this.success});

  DbModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <DbLink>[];
      json['result'].forEach((v) {
        result!.add(new DbLink.fromJson(v));
      });
    }
    errors = json['errors'].cast<String>();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    data['success'] = this.success;
    return data;
  }
}

class DbLink {
  int? id;
  String? appName;
  String? v1;
  String? v2;
  String? v3;
  String? v4;
  String? v5;
  String? v6;
  String? createdAt;
  String? updatedAt;

  DbLink(
      {this.id,
        this.appName,
        this.v1,
        this.v2,
        this.v3,
        this.v4,
        this.v5,
        this.v6,
        this.createdAt,
        this.updatedAt});

  DbLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    v1 = json['v1'];
    v2 = json['v2'];
    v3 = json['v3'];
    v4 = json['v4'];
    v5 = json['v5'];
    v6 = json['v6'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['v1'] = this.v1;
    data['v2'] = this.v2;
    data['v3'] = this.v3;
    data['v4'] = this.v4;
    data['v5'] = this.v5;
    data['v6'] = this.v6;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
