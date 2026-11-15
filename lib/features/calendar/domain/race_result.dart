/// 一场分站正赛的车手结果。
class RaceResult {
  const RaceResult({
    required this.position,
    required this.positionText,
    required this.points,
    required this.driverId,
    required this.driverName,
    required this.constructorId,
    required this.constructorName,
    required this.status,
  });

  final String position;
  final String positionText;
  final String points;
  final String driverId;
  final String driverName;
  final String constructorId;
  final String constructorName;
  final String status;

  int get positionValue => int.tryParse(position) ?? 99;

  double get pointsValue => double.tryParse(points) ?? 0;
}
