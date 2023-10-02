import 'dart:convert';

import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/widgets/alarm_info.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'models/farm/sensor.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), false,
      description: "Office"),
];
final channel = WebSocketChannel.connect(
  Uri.parse('ws://115.79.196.171:1234'),
);

void sendData() {
  channel.sink.add(json.encode(globalData));
  // if (_controller.text.isNotEmpty) {
  //   _channel.sink.add(_controller.text);
  // }
}

var dataSensor = Sensor(0, "NaN", "NaN", "NaN", "NaN");
List<Task> dayObjectList = [
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
  Task(status: false, hour: 7, minute: 17, timer: 17),
];

Map<String, dynamic> globalData = {
  "_id": 1,
  "infor": {
    "statusValve": {"valve1": 3, "valve2": 3, "valve3": 3, "valve4": 3},
    "dayObjectList": [
      {
        "day": 1,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56a"
      },
      {
        "day": 2,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56b"
      },
      {
        "day": 3,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56c"
      },
      {
        "day": 4,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56d"
      },
      {
        "day": 5,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56e"
      },
      {
        "day": 6,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e56f"
      },
      {
        "day": 0,
        "status": false,
        "hour": 2,
        "minute": 45,
        "second": 0,
        "timer": 15,
        "_id": "6601911da50e57fe3f90e570"
      }
    ],
    "status": {
      "manual": 3,
      "auto": 3,
      "sensor": 3,
    },
    "sensor": {
      "high": 30,
      "low": 20,
    },
    "_id": 1,
  },
};
void updateValveDay(Task data) {
  globalData['infor']['status']['auto'] = 1;
  globalData['infor']['dayObjectList'][data.id]['status'] = data.status;
  globalData['infor']['dayObjectList'][data.id]['hour'] = data.hour;
  globalData['infor']['dayObjectList'][data.id]['minute'] = data.minute;
  globalData['infor']['dayObjectList'][data.id]['timer'] = data.timer;
  sendData();
}
