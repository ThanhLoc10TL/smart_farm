import 'package:flutter_app/models/farm/value_sensor.dart';

class SensorStatus {
  String? id;
  int? timeSave;
  ValueSensor? value;
  SensorStatus(this.id, this.timeSave, this.value);
  SensorStatus.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        timeSave = json['timeSave'],
        value = ValueSensor.fromJson(json['value']);
}
