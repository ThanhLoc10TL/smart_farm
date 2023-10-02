import 'package:flutter_app/models/farm/sensor_status.dart';

class Status {
  String? id;
  int? sensor;
  List<SensorStatus>? sensorStatus;
  Status(this.id, this.sensor, this.sensorStatus);
  Status.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        sensor = json['sensor'],
        sensorStatus = (json['sensorStatus'] as List<dynamic>)
            .map((e) => SensorStatus.fromJson(e as Map<String, dynamic>))
            .toList();
}
