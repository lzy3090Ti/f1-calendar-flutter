import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'race_response.dart';
import 'race_result_response.dart';

part 'race_api.g.dart';

/// 赛历远程接口。Jolpica-F1 免费、无需 key。
@RestApi(baseUrl: 'https://api.jolpi.ca/ergast/f1')
abstract class RaceApi {
  factory RaceApi(Dio dio, {String baseUrl}) = _RaceApi;

  /// 整个赛季赛历。limit 取 100 以免未来分站数超过默认分页上限。
  @GET('/{season}.json')
  Future<RaceTableResponse> fetchSeasonRaces(
    @Path('season') String season, {
    @Query('limit') String limit = '100',
  });

  @GET('/{season}/{round}/results.json')
  Future<RaceResultsResponse> fetchRaceResults(
    @Path('season') String season,
    @Path('round') String round, {
    @Query('limit') String limit = '100',
  });
}
