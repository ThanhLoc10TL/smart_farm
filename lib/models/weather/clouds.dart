import 'package:json_annotation/json_annotation.dart';
part 'clouds.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Clouds {
  Clouds(this.all);

  int all;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}
