import "package:freezed_annotation/freezed_annotation.dart";

part "user_model.freezed.dart";

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    String? phone_number,
  }) = _User;
}

@freezed
class UserLow with _$UserLow {
  const factory UserLow({
    required int id,
    required String name,
  }) = _UserLow;
}
