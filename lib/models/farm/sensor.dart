class Sensor {
  int? id;
  String? modeManual;
  String? modeAuto;
  String? modeSensor;
  String? dataSensor;
  String? temp;
  String? humi;
  StatusValve? statusSubValve;
  bool stateValve = false;
  Sensor(this.id, this.modeManual, this.modeAuto, this.modeSensor,
      this.dataSensor) {
    //modeSensor == 'sensor_on' ? stateValve = true : stateValve = false;
    getData();
  }

  getData() {
    modeManual == 'manual_on' ? stateValve = true : stateValve = false;
    if ((dataSensor != null)) {
      final str = dataSensor?.split('|');
      if (str!.length > 1) {
        temp = str[0].toString();
        humi = str[1].toString();
      } else {
        temp = "NaN";
        humi = "NaN";
      }
    } else {
      temp = "NaN";
      humi = "NaN";
    }
  }

  Sensor.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        modeManual = json['modeManual'] ?? 'NaN',
        modeAuto = json['modeAuto'] ?? 'NaN',
        modeSensor = json['modeSensor'] ?? 'NaN',
        dataSensor = json['dataSensor'] ?? 'NaN',
        statusSubValve = json['statusValve'] == null
            ? StatusValve.fromJson(json['infor']['statusValve'])
            : StatusValve.fromJson(json['statusValve']);

  Map<String, dynamic> toJson() => {
        '_id': id,
        'modeManual': modeManual,
        'modeAuto': modeAuto,
        'modeSensor': modeSensor,
        'dataSensor': dataSensor
      };
}

class StatusValve {
  int? valve1;
  int? valve2;
  int? valve3;
  int? valve4;
  StatusValve(this.valve1, this.valve2, this.valve3, this.valve4);
  StatusValve.fromJson(Map<String, dynamic> json) {
    valve1 = json['valve1'] ?? Null;
    valve2 = json['valve2'] ?? Null;
    valve3 = json['valve3'] ?? Null;
    valve4 = json['valve4'] ?? Null;
  }
  Map<String, dynamic> toJson() =>
      {'valve1': valve1, 'valve2': valve2, 'valve3': valve3, 'valve4': valve4};
}
