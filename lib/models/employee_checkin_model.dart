class EmployeeCheckInModel {
  List<Data>? data;

  EmployeeCheckInModel({this.data});

  EmployeeCheckInModel.fromMap(Map<String, dynamic> json) {
    if (json['data'] != null) {
      print('here');
      print(json['data']);
      data = <Data>[];
      (json['data'] as List).forEach((v) {
        data!.add(Data.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Data {
  String? name;

  Data({this.name});

  Data.fromMap(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
