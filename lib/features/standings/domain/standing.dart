import 'package:freezed_annotation/freezed_annotation.dart';

part 'standing.freezed.dart';
part 'standing.g.dart';

/// 车队积分榜中的一行。
///
/// 接口数值字段均为字符串（`positionText` 可能是 "DQ" 等），
/// 这里保留原始值并暴露安全的数值 getter。
@freezed
abstract class ConstructorStanding with _$ConstructorStanding {
  const ConstructorStanding._();

  const factory ConstructorStanding({
    required String position,
    required String positionText,
    required String points,
    required String wins,
    required ConstructorInfo constructor,
    /// 与上一轮缓存相比的名次变化：正数为上升，负数为下降，0 为不变。
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(0)
    int positionChange,
  }) = _ConstructorStanding;

  factory ConstructorStanding.fromJson(Map<String, dynamic> json) =>
      _$ConstructorStandingFromJson(json);

  int get positionValue => int.tryParse(position) ?? 0;

  double get pointsValue => double.tryParse(points) ?? 0;

  int get winsValue => int.tryParse(wins) ?? 0;

  String get constructorId => constructor.constructorId;
}

@freezed
abstract class ConstructorInfo with _$ConstructorInfo {
  const factory ConstructorInfo({
    required String constructorId,
    required String name,
    required String nationality,
  }) = _ConstructorInfo;

  factory ConstructorInfo.fromJson(Map<String, dynamic> json) =>
      _$ConstructorInfoFromJson(json);
}