// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructorStanding _$ConstructorStandingFromJson(Map<String, dynamic> json) =>
    _ConstructorStanding(
      position: json['position'] as String,
      positionText: json['positionText'] as String,
      points: json['points'] as String,
      wins: json['wins'] as String,
      constructor: ConstructorInfo.fromJson(
        json['constructor'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConstructorStandingToJson(
  _ConstructorStanding instance,
) => <String, dynamic>{
  'position': instance.position,
  'positionText': instance.positionText,
  'points': instance.points,
  'wins': instance.wins,
  'constructor': instance.constructor,
};

_ConstructorInfo _$ConstructorInfoFromJson(Map<String, dynamic> json) =>
    _ConstructorInfo(
      constructorId: json['constructorId'] as String,
      name: json['name'] as String,
      nationality: json['nationality'] as String,
    );

Map<String, dynamic> _$ConstructorInfoToJson(_ConstructorInfo instance) =>
    <String, dynamic>{
      'constructorId': instance.constructorId,
      'name': instance.name,
      'nationality': instance.nationality,
    };
