import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

/// 一份 HTTP 缓存条目：响应原文 + 校验器 + 抓取时间。
///
/// 只用 Hive 存字符串，避免引入 adapter 生成链路，也让缓存内容可读、可迁移。
class CachedPayload {
  const CachedPayload({
    required this.body,
    required this.fetchedAt,
    this.etag,
    this.lastModified,
  });

  final String body;
  final DateTime fetchedAt;
  final String? etag;
  final String? lastModified;

  bool isFresh(Duration ttl, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    return reference.difference(fetchedAt) < ttl;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'body': body,
        'fetchedAt': fetchedAt.toUtc().toIso8601String(),
        'etag': etag,
        'lastModified': lastModified,
      };

  factory CachedPayload.fromJson(Map<String, dynamic> json) {
    return CachedPayload(
      body: json['body'] as String? ?? '{}',
      fetchedAt:
          DateTime.tryParse(json['fetchedAt'] as String? ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      etag: json['etag'] as String?,
      lastModified: json['lastModified'] as String?,
    );
  }
}

/// 基于 Hive 的键值缓存。图片缓存由 cached_network_image 自己的磁盘缓存负责。
class CacheStore {
  CacheStore(this._box);

  static const String boxName = 'f1_cache';

  final Box<String> _box;

  static Future<CacheStore> open() async {
    await Hive.initFlutter();
    final box = await Hive.openBox<String>(boxName);
    return CacheStore(box);
  }

  CachedPayload? read(String key) {
    final raw = _box.get(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return CachedPayload.fromJson(decoded);
      }
    } on FormatException {
      return null;
    }
    return null;
  }

  Future<void> write(String key, CachedPayload payload) =>
      _box.put(key, jsonEncode(payload.toJson()));

  /// 304 命中时只刷新时间戳，保留原 body 与 etag。
  Future<CachedPayload?> touch(String key, DateTime fetchedAt) async {
    final entry = read(key);
    if (entry == null) return null;
    final updated = CachedPayload(
      body: entry.body,
      fetchedAt: fetchedAt,
      etag: entry.etag,
      lastModified: entry.lastModified,
    );
    await write(key, updated);
    return updated;
  }

  Future<void> remove(String key) => _box.delete(key);

  Iterable<String> get keys => _box.keys.whereType<String>();
}