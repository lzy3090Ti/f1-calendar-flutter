import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/race_api.dart';
import '../data/race_cache.dart';
import '../data/race_repository_impl.dart';
import '../domain/get_next_race.dart';
import '../domain/race.dart';
import '../domain/race_repository.dart';
import '../domain/race_result.dart';
import '../../widgets/widget_sync_service.dart';

final Provider<RaceApi> raceApiProvider = Provider<RaceApi>(
  (ref) => RaceApi(ref.watch(dioProvider)),
);

final Provider<RaceCache> raceCacheProvider = Provider<RaceCache>(
  (ref) => RaceCache(
    ref.watch(cacheStoreProvider),
    season: ref.watch(seasonProvider),
  ),
);

final Provider<RaceRepository> raceRepositoryProvider =
    Provider<RaceRepository>(
      (ref) => RaceRepositoryImpl(
        api: ref.watch(raceApiProvider),
        cache: ref.watch(raceCacheProvider),
        season: '${ref.watch(seasonProvider)}',
      ),
    );

final raceResultsProvider = FutureProvider.autoDispose
    .family<List<RaceResult>, String>((ref, round) async {
      final response = await ref
          .watch(raceApiProvider)
          .fetchRaceResults('${ref.watch(seasonProvider)}', round);
      return response.results;
    });

final AsyncNotifierProvider<RacesNotifier, List<Race>> racesProvider =
    AsyncNotifierProvider<RacesNotifier, List<Race>>(RacesNotifier.new);

/// 赛历状态：已有缓存立即展示，过期时后台刷新（stale-while-revalidate）。
class RacesNotifier extends AsyncNotifier<List<Race>> {
  @override
  Future<List<Race>> build() async {
    final repository = ref.watch(raceRepositoryProvider);
    final cached = await repository.readCachedRaces();
    if (cached != null && cached.isNotEmpty) {
      unawaited(WidgetSyncService.syncRace(cached));
      if (await repository.isCacheStale()) {
        // 延迟到 build 完成后再写 state，避免在构建期更新状态。
        unawaited(
          Future<void>.delayed(
            Duration.zero,
            () => _refreshSilently(repository),
          ),
        );
      }
      return cached;
    }
    final fresh = await repository.getRaces();
    unawaited(WidgetSyncService.syncRace(fresh));
    return fresh;
  }

  /// 下拉刷新：保留当前内容，失败时由页面提示，不把页面变成错误态。
  Future<void> refresh() async {
    final repository = ref.read(raceRepositoryProvider);
    final previous = state;
    try {
      final fresh = await repository.getRaces(forceRefresh: true);
      unawaited(WidgetSyncService.syncRace(fresh));
      state = AsyncData<List<Race>>(fresh);
    } on Object {
      state = previous;
      rethrow;
    }
  }

  Future<void> _refreshSilently(RaceRepository repository) async {
    try {
      final fresh = await repository.getRaces(forceRefresh: true);
      state = AsyncData<List<Race>>(fresh);
    } on Object {
      // 弱网或接口异常：继续展示缓存，不打扰用户。
    }
  }
}

/// 下一场尚未开始的比赛；整季结束为 null。
final Provider<Race?> nextRaceProvider = Provider<Race?>((ref) {
  final races = ref.watch(racesProvider).asData?.value;
  if (races == null || races.isEmpty) return null;
  return const GetNextRace().call(races, DateTime.now());
});
