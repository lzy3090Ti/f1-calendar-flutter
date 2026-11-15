import 'dart:ui' show Color;

import '../../features/calendar/domain/race.dart';

const Map<String, String> _countryZh = <String, String>{
  'Australia': '澳大利亚',
  'Austria': '奥地利',
  'Azerbaijan': '阿塞拜疆',
  'Bahrain': '巴林',
  'Belgium': '比利时',
  'Brazil': '巴西',
  'Canada': '加拿大',
  'China': '中国',
  'France': '法国',
  'Germany': '德国',
  'Hungary': '匈牙利',
  'India': '印度',
  'Italy': '意大利',
  'Japan': '日本',
  'Korea': '韩国',
  'Malaysia': '马来西亚',
  'Mexico': '墨西哥',
  'Monaco': '摩纳哥',
  'Netherlands': '荷兰',
  'Portugal': '葡萄牙',
  'Qatar': '卡塔尔',
  'Russia': '俄罗斯',
  'Saudi Arabia': '沙特阿拉伯',
  'Singapore': '新加坡',
  'South Africa': '南非',
  'Spain': '西班牙',
  'Turkey': '土耳其',
  'UAE': '阿联酋',
  'UK': '英国',
  'USA': '美国',
  'United States': '美国',
  'Vietnam': '越南',
};

const Map<String, String> _localityZh = <String, String>{
  'Abu Dhabi': '阿布扎比',
  'Austin': '奥斯汀',
  'Baku': '巴库',
  'Barcelona': '巴塞罗那',
  'Budapest': '布达佩斯',
  'Jeddah': '吉达',
  'Las Vegas': '拉斯维加斯',
  'Lusail': '卢赛尔',
  'Melbourne': '墨尔本',
  'Mexico City': '墨西哥城',
  'Miami': '迈阿密',
  'Monte Carlo': '蒙特卡洛',
  'Montreal': '蒙特利尔',
  'Monza': '蒙扎',
  'Sakhir': '萨基尔',
  'Shanghai': '上海',
  'Silverstone': '银石',
  'Singapore': '新加坡',
  'Spa': '斯帕',
  'Spielberg': '施皮尔伯格',
  'Suzuka': '铃鹿',
  'São Paulo': '圣保罗',
  'Zandvoort': '赞德福特',
};

const Map<String, int> _countryBaseColor = <String, int>{
  'Australia': 0xFF3D7EAA,
  'Austria': 0xFFB03A4A,
  'Azerbaijan': 0xFF3E8E79,
  'Bahrain': 0xFFB98B3C,
  'Belgium': 0xFFB89A3A,
  'Brazil': 0xFF3F8E5A,
  'Canada': 0xFFC0564A,
  'China': 0xFFB23A48,
  'Hungary': 0xFF7A9A4E,
  'Italy': 0xFF2F7F86,
  'Japan': 0xFF8E5A9E,
  'Mexico': 0xFF7C9A4E,
  'Monaco': 0xFF9C4F6A,
  'Netherlands': 0xFFD2691E,
  'Qatar': 0xFF6E5A9E,
  'Saudi Arabia': 0xFF2E8B57,
  'Singapore': 0xFFC25E3A,
  'Spain': 0xFFC97B2E,
  'UAE': 0xFFC79A4A,
  'UK': 0xFF4B6E9E,
  'USA': 0xFF4A5FA5,
};

String countryZh(String country) => _countryZh[country] ?? country;

String localityZh(String locality) => _localityZh[locality] ?? locality;

/// 分站中文标题。美国有三站，改用城市名区分，避免三个「美国大奖赛」。
String raceTitleZh(Race race) {
  final country = race.country;
  if (country == 'USA' || country == 'United States') {
    return '${localityZh(race.locality)}大奖赛';
  }
  return '${countryZh(country)}大奖赛';
}

const List<String> _circuitSuffixes = <String>[
  'Permanent Racing Facility',
  'Motor Racing Circuit',
  'Grand Prix Circuit',
  'International Circuit',
  'Street Circuit',
  'International Circuit',
  'Circuit',
];

/// 把 "Albert Park Grand Prix Circuit" 这类长名压成 "Albert Park"。
String shortCircuitName(String circuitName) {
  var name = circuitName.trim();
  for (final suffix in _circuitSuffixes) {
    if (name.toLowerCase().endsWith(suffix.toLowerCase())) {
      name = name.substring(0, name.length - suffix.length).trim();
      break;
    }
  }
  name = name.replaceAll(RegExp(r'\s+Grand Prix$'), '').trim();
  return name.isEmpty ? circuitName : name;
}

/// 分站卡片背景：低饱和、双色渐变；深色模式整体压暗，不做强对比。
List<Color> raceGradient(Race race, {required bool dark}) {
  final base = Color(_countryBaseColor[race.country] ?? 0xFF4B6E9E);
  final anchor = dark ? const Color(0xFF1F1F1F) : const Color(0xFFFFFFFF);
  final start = Color.lerp(base, anchor, dark ? 0.80 : 0.86)!;
  final end = Color.lerp(base, anchor, dark ? 0.66 : 0.68)!;
  return <Color>[start, end];
}