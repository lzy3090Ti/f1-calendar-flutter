// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Race _$RaceFromJson(Map<String, dynamic> json) => _Race(
  season: json['season'] as String,
  round: json['round'] as String,
  raceName: json['raceName'] as String,
  circuit: Circuit.fromJson(json['circuit'] as Map<String, dynamic>),
  date: json['date'] as String,
  time: json['time'] as String?,
  firstPractice: json['FirstPractice'] == null
      ? null
      : RaceSession.fromJson(json['FirstPractice'] as Map<String, dynamic>),
  secondPractice: json['SecondPractice'] == null
      ? null
      : RaceSession.fromJson(json['SecondPractice'] as Map<String, dynamic>),
  thirdPractice: json['ThirdPractice'] == null
      ? null
      : RaceSession.fromJson(json['ThirdPractice'] as Map<String, dynamic>),
  qualifying: json['Qualifying'] == null
      ? null
      : RaceSession.fromJson(json['Qualifying'] as Map<String, dynamic>),
  sprint: json['Sprint'] == null
      ? null
      : RaceSession.fromJson(json['Sprint'] as Map<String, dynamic>),
  sprintQualifying: json['SprintQualifying'] == null
      ? null
      : RaceSession.fromJson(json['SprintQualifying'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RaceToJson(_Race instance) => <String, dynamic>{
  'season': instance.season,
  'round': instance.round,
  'raceName': instance.raceName,
  'circuit': instance.circuit,
  'date': instance.date,
  'time': instance.time,
  'FirstPractice': instance.firstPractice,
  'SecondPractice': instance.secondPractice,
  'ThirdPractice': instance.thirdPractice,
  'Qualifying': instance.qualifying,
  'Sprint': instance.sprint,
  'SprintQualifying': instance.sprintQualifying,
};

_RaceSession _$RaceSessionFromJson(Map<String, dynamic> json) =>
    _RaceSession(date: json['date'] as String, time: json['time'] as String?);

Map<String, dynamic> _$RaceSessionToJson(_RaceSession instance) =>
    <String, dynamic>{'date': instance.date, 'time': instance.time};

_Circuit _$CircuitFromJson(Map<String, dynamic> json) => _Circuit(
  circuitId: json['circuitId'] as String,
  circuitName: json['circuitName'] as String,
  location: CircuitLocation.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CircuitToJson(_Circuit instance) => <String, dynamic>{
  'circuitId': instance.circuitId,
  'circuitName': instance.circuitName,
  'location': instance.location,
};

_CircuitLocation _$CircuitLocationFromJson(Map<String, dynamic> json) =>
    _CircuitLocation(
      lat: json['lat'] as String,
      long: json['long'] as String,
      locality: json['locality'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$CircuitLocationToJson(_CircuitLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'locality': instance.locality,
      'country': instance.country,
    };
