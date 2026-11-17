import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'driver_standings_response.dart';
import 'standings_response.dart';

part 'standings_api.g.dart';

/// 车队积分榜远程接口。Jolpica-F1 免费、无需 key。
@RestApi(baseUrl: 'https://api.jolpi.ca/ergast/f1')
abstract class StandingsApi {
  factory StandingsApi(Dio dio, {String baseUrl}) = _StandingsApi;

  @GET('/{season}/constructorStandings.json')
  Future<StandingsResponse> fetchConstructorStandings(
    @Path('season') String season, {
    @Query('limit') String limit = '100',
  });
  @GET('/{season}/driverStandings.json')
  Future<DriverStandingsResponse> fetchDriverStandings(
    @Path('season') String season, {
    @Query('limit') String limit = '100',
  });
}
