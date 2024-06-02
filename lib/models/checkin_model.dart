class CheckInModel {
  String employee;
  String employeeName;
  String logType;
  DateTime time;
  String customLatitude;
  String customLongitude;

  CheckInModel(
      {required this.employee,
      required this.employeeName,
      required this.logType,
      required this.time,
      required this.customLatitude,
      required this.customLongitude});

  factory CheckInModel.fromMap(Map<String, dynamic> json) {
    return CheckInModel(employee: json['employee'],
    employeeName: json['employee_name'],
    logType: json['log_type'],
    time: DateTime.parse(json['time']),
    customLatitude: json['custom_latitude'],
    customLongitude: json['custom_longitude']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee'] = employee;
    data['employee_name'] = employeeName;
    data['log_type'] = logType;
    data['time'] = time.toString();
    data['custom_latitude'] = customLatitude;
    data['custom_longitude'] = customLongitude;
    return data;
  }
}
