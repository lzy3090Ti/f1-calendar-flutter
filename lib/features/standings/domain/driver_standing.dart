import 'standing.dart';

/// Jolpica 返回的车手积分行。保留接口原始字符串，兼容 DNF、DNS 等位置文本。
class DriverStanding {
  const DriverStanding({
    required this.position,
    required this.positionText,
    required this.points,
    required this.wins,
    required this.driver,
    required this.constructor,
    this.positionChange = 0,
  });

  final String position;
  final String positionText;
  final String points;
  final String wins;
  final DriverInfo driver;
  final ConstructorInfo constructor;
  final int positionChange;

  int get positionValue => int.tryParse(position) ?? 0;
  double get pointsValue => double.tryParse(points) ?? 0;
  String get constructorId => constructor.constructorId;

  DriverStanding copyWith({int? positionChange}) => DriverStanding(
    position: position,
    positionText: positionText,
    points: points,
    wins: wins,
    driver: driver,
    constructor: constructor,
    positionChange: positionChange ?? this.positionChange,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'position': position,
    'positionText': positionText,
    'points': points,
    'wins': wins,
    'Driver': driver.toJson(),
    'Constructor': <String, dynamic>{
      'constructorId': constructor.constructorId,
      'name': constructor.name,
      'nationality': constructor.nationality,
    },
  };

  factory DriverStanding.fromJson(Map<String, dynamic> json) {
    final driverRaw = json['Driver'] ?? json['driver'];
    final constructorRaw = json['Constructor'] ?? json['constructor'];
    final driver = DriverInfo.fromJson(
      driverRaw is Map
          ? Map<String, dynamic>.from(driverRaw)
          : const <String, dynamic>{},
    );
    final constructor = ConstructorInfo.fromJson(
      constructorRaw is Map
          ? Map<String, dynamic>.from(constructorRaw)
          : const <String, dynamic>{},
    );
    return DriverStanding(
      position: '${json['position'] ?? ''}',
      positionText: '${json['positionText'] ?? json['position'] ?? ''}',
      points: '${json['points'] ?? '0'}',
      wins: '${json['wins'] ?? '0'}',
      driver: driver,
      constructor: constructor,
    );
  }
}

class DriverInfo {
  const DriverInfo({
    required this.driverId,
    required this.givenName,
    required this.familyName,
    required this.nationality,
  });

  final String driverId;
  final String givenName;
  final String familyName;
  final String nationality;

  String get fullName => '$givenName $familyName'.trim();

  Map<String, dynamic> toJson() => <String, dynamic>{
    'driverId': driverId,
    'givenName': givenName,
    'familyName': familyName,
    'nationality': nationality,
  };

  factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
    driverId: '${json['driverId'] ?? ''}',
    givenName: '${json['givenName'] ?? ''}',
    familyName: '${json['familyName'] ?? ''}',
    nationality: '${json['nationality'] ?? ''}',
  );
}
