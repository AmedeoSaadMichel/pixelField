import 'package:json_annotation/json_annotation.dart';
part 'accounts.g.dart';

@JsonSerializable()
class Account {
  /// The generated code assumes these values exist in JSON.
  final String name, email,password;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.


  Account({required this.name, required this.email,required this.password});

  /// Connect the generated [_$AccountFromJson] function to the `fromJson`
  /// factory.
  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  /// Connect the generated [_$AccountToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}