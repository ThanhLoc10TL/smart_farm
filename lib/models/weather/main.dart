import 'package:json_annotation/json_annotation.dart';
part 'main.g.dart';

@JsonSerializable()
class Main {
  double? temp;
  double? feels_like;
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? humidity;

  Main({
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}
