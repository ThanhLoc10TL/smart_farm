class Node {
  int? id;
  Infor? infor;
  Node(this.id, this.infor);
  Map<String, dynamic> toJson() => {'_id': id, 'infor': infor?.toJson()};
}

class Infor {
  Status? status;
  Sensor? sensor;
  Infor(this.status, this.sensor);
  Map<String, dynamic> toJson() =>
      {'status': status?.toJson(), 'sensor': sensor?.toJson()};
}

class Status {
  int? manual;
  int? auto;
  int? sensor;
  Status(this.manual, this.auto, this.sensor);
  Map<String, dynamic> toJson() =>
      {'manual': manual, 'auto': auto, 'sensor': sensor};
}

class Sensor {
  int? high;
  int? low;
  Sensor(this.high, this.low);
  Map<String, dynamic> toJson() => {'high': high, 'low': low};
}
