import "package:freezed_annotation/freezed_annotation.dart";

part "beacon_model.freezed.dart";

@freezed
class Beacon with _$Beacon {
  const factory Beacon({
    required String name,
    required String data_type,
    required String data,
  }) = _Beacon;
}
