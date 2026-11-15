import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/standings_api.dart';
import '../data/standings_cache.dart';
import '../data/standings_repository_impl.dart';
import '../domain/standing.dart';
import '../domain/standings_repository.dart';

final Provider<StandingsApi> standingsApiProvider = Provider<StandingsApi>(
  (ref) => StandingsApi(ref.watch(dioProvider)),
);

final Provider<StandingsCache> standingsCacheProvider = Provider<StandingsCache>(
  (ref) => StandingsCache(
    ref.watch(cacheStoreProvider),
    season: ref.watch(seasonProvider),
  ),
);

final Provider<StandingsRepository> standingsRepositoryProvider =
    Provider<StandingsRepository>(
  (ref) => StandingsRepositoryImpl(
    api: ref.watch(standingsApiProvider),
    cache: ref.watch(standingsCacheProvider),
    season: '${ref.watch(seasonProvider)}',
  ),
);

final AsyncNotifierProvider<StandingsNotifier, List<ConstructorStanding>>
    standingsProvider =
    AsyncNotifierProvider<StandingsNotifier, List<ConstructorStanding>>(
  StandingsNotifier.new,
);

class StandingsNotifier extends AsyncNotifier<List<ConstructorStanding>> {
  @override
  Future<List<ConstructorStanding>> build() async {
    final repository = ref.watch(standingsRepositoryProvider);
    final cached = await repository.readCachedStandings();
    if (cached != null && cached.isNotEmpty) {
      if (await repository.isCacheStale()) {
        unawaited(
          Future<void>.delayed(
            Duration.zero,
            () => _refreshSilently(repository),
          ),
        );
      }
      return cached;
    }
    return repository.getStandings();
  }

  Future<void> refresh() async {
    final repository = ref.read(standingsRepositoryProvider);
    final previous = state;
    try {
      final fresh = await repository.getStandings(forceRefresh: true);
      state = AsyncData<List<ConstructorStanding>>(fresh);
    } on Object {
      state = previous;
      rethrow;
    }
  }

  Future<void> _refreshSilently(StandingsRepository repository) async {
    try {
      final fresh = await repository.getStandings(forceRefresh: true);
      state = AsyncData<List<ConstructorStanding>>(fresh);
    } on Object {
      // 保留缓存，不做打扰。
    }
  }
}

/// 按车队 ID 取当前积分行，供详情页使用。
final standingByTeamProvider =
    Provider.family<ConstructorStanding?, String>((ref, constructorId) {
  final rows = ref.watch(standingsProvider).asData?.value;
  if (rows == null) return null;
  for (final row in rows) {
    if (row.constructorId == constructorId) return row;
  }
  return null;
});