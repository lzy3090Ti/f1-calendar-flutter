import 'dart:ui' show Color;

/// 车队 / 车手静态素材映射表。
///
/// 整个 App 只在这里维护「车队 ID → 车图、队色、车手头像」，
/// UI 按 constructorId 取值，换素材只改这一处。
class TeamAsset {
  const TeamAsset({
    required this.id,
    required this.slug,
    required this.name,
    required this.nameZh,
    required this.colorHex,
    required this.drivers,
  });

  /// Ergast/Jolpica 的 constructorId。
  final String id;

  /// formula1.com 素材路径中的车队 slug。
  final String slug;

  final String name;
  final String nameZh;
  final int colorHex;
  final List<DriverAsset> drivers;

  Color get color => Color(colorHex);

  /// 官方车图为 Cloudinary 变换地址，改 w_ 即可取合适尺寸。
  String carUrl({int width = 600}) =>
      'https://media.formula1.com/image/upload/fl_preserve_transparency,c_fit,w_$width/q_auto/v1740000001/'
      'common/f1/$seasonSegment/$slug/$seasonSegment${slug}carleft.jpg';

  String get carUrlList => carUrl(width: 600);

  String get carUrlDetail => carUrl(width: 1200);

  static const String seasonSegment = '2026';
}

class DriverAsset {
  const DriverAsset({
    required this.code,
    required this.name,
    required this.nameZh,
    this.id = '',
  });

  /// Jolpica/Ergast 的 driverId，用于把真实积分映射到官方素材。
  final String id;

  /// 素材路径中的车手代码，例如 `georus01`。
  final String code;
  final String name;
  final String nameZh;

  String avatarUrl({String slug = '', int width = 440}) =>
      'https://media.formula1.com/image/upload/c_fit,w_$width/q_auto/v1740000001/'
      'common/f1/${TeamAsset.seasonSegment}/$slug/$code/'
      '${TeamAsset.seasonSegment}$slug${code}right.webp';
}

const List<TeamAsset> teamAssets = <TeamAsset>[
  TeamAsset(
    id: 'mercedes',
    slug: 'mercedes',
    name: 'Mercedes',
    nameZh: '梅赛德斯',
    colorHex: 0xFF00D2BE,
    drivers: <DriverAsset>[
      DriverAsset(code: 'georus01', name: 'George Russell', nameZh: '拉塞尔'),
      DriverAsset(code: 'andant01', name: 'Kimi Antonelli', nameZh: '安东内利'),
    ],
  ),
  TeamAsset(
    id: 'ferrari',
    slug: 'ferrari',
    name: 'Ferrari',
    nameZh: '法拉利',
    colorHex: 0xFFE8002D,
    drivers: <DriverAsset>[
      DriverAsset(code: 'lewham01', name: 'Lewis Hamilton', nameZh: '汉密尔顿'),
      DriverAsset(code: 'chalec01', name: 'Charles Leclerc', nameZh: '勒克莱尔'),
    ],
  ),
  TeamAsset(
    id: 'red_bull',
    slug: 'redbullracing',
    name: 'Red Bull Racing',
    nameZh: '红牛',
    colorHex: 0xFF3671C6,
    drivers: <DriverAsset>[
      DriverAsset(code: 'maxver01', name: 'Max Verstappen', nameZh: '维斯塔潘'),
      DriverAsset(code: 'isahad01', name: 'Isack Hadjar', nameZh: '哈贾尔'),
    ],
  ),
  TeamAsset(
    id: 'mclaren',
    slug: 'mclaren',
    name: 'McLaren',
    nameZh: '迈凯伦',
    colorHex: 0xFFFF8000,
    drivers: <DriverAsset>[
      DriverAsset(code: 'lannor01', name: 'Lando Norris', nameZh: '诺里斯'),
      DriverAsset(code: 'oscpia01', name: 'Oscar Piastri', nameZh: '皮亚斯特里'),
    ],
  ),
  TeamAsset(
    id: 'rb',
    slug: 'racingbulls',
    name: 'Racing Bulls',
    nameZh: '小红牛',
    colorHex: 0xFF6692FF,
    drivers: <DriverAsset>[
      DriverAsset(code: 'lialaw01', name: 'Liam Lawson', nameZh: '劳森'),
      DriverAsset(code: 'arvlin01', name: 'Arvid Lindblad', nameZh: '林德布拉德'),
    ],
  ),
  TeamAsset(
    id: 'alpine',
    slug: 'alpine',
    name: 'Alpine',
    nameZh: 'Alpine',
    colorHex: 0xFFFF87BC,
    drivers: <DriverAsset>[
      DriverAsset(code: 'piegas01', name: 'Pierre Gasly', nameZh: '加斯利'),
      DriverAsset(code: 'fracol01', name: 'Franco Colapinto', nameZh: '科拉平托'),
    ],
  ),
  TeamAsset(
    id: 'haas',
    slug: 'haas',
    name: 'Haas',
    nameZh: '哈斯',
    colorHex: 0xFFB6BABD,
    drivers: <DriverAsset>[
      DriverAsset(code: 'olibea01', name: 'Oliver Bearman', nameZh: '贝尔曼'),
      DriverAsset(code: 'rafcam01', name: 'Rafael Camara', nameZh: '卡马拉'),
    ],
  ),
  TeamAsset(
    id: 'audi',
    slug: 'audi',
    name: 'Audi',
    nameZh: '奥迪',
    colorHex: 0xFFBB0A30,
    drivers: <DriverAsset>[
      DriverAsset(code: 'nichul01', name: 'Nico Hulkenberg', nameZh: '霍肯伯格'),
      DriverAsset(code: 'gabbor01', name: 'Gabriel Bortoleto', nameZh: '博托莱托'),
    ],
  ),
  TeamAsset(
    id: 'williams',
    slug: 'williams',
    name: 'Williams',
    nameZh: '威廉姆斯',
    colorHex: 0xFF00A0DE,
    drivers: <DriverAsset>[
      DriverAsset(code: 'alealb01', name: 'Alexander Albon', nameZh: '阿尔本'),
      DriverAsset(code: 'carsai01', name: 'Carlos Sainz', nameZh: '塞恩斯'),
    ],
  ),
  TeamAsset(
    id: 'aston_martin',
    slug: 'astonmartin',
    name: 'Aston Martin',
    nameZh: '阿斯顿马丁',
    colorHex: 0xFF229971,
    drivers: <DriverAsset>[
      DriverAsset(code: 'feralo01', name: 'Fernando Alonso', nameZh: '阿隆索'),
      DriverAsset(code: 'lanstr01', name: 'Lance Stroll', nameZh: '斯特罗尔'),
    ],
  ),
  TeamAsset(
    id: 'cadillac',
    slug: 'cadillac',
    name: 'Cadillac',
    nameZh: '凯迪拉克',
    colorHex: 0xFFC9A227,
    drivers: <DriverAsset>[
      DriverAsset(code: 'valbot01', name: 'Valtteri Bottas', nameZh: '博塔斯'),
      DriverAsset(code: 'serper01', name: 'Sergio Perez', nameZh: '佩雷兹'),
    ],
  ),
];

final Map<String, TeamAsset> _teamAssetsById = <String, TeamAsset>{
  for (final team in teamAssets) team.id: team,
};

const Map<String, String> _driverCodeById = <String, String>{
  'russell': 'georus01',
  'antonelli': 'andant01',
  'hamilton': 'lewham01',
  'leclerc': 'chalec01',
  'verstappen': 'maxver01',
  'max_verstappen': 'maxver01',
  'hadjar': 'isahad01',
  'norris': 'lannor01',
  'piastri': 'oscpia01',
  'lawson': 'lialaw01',
  'lindblad': 'arvlin01',
  'gasly': 'piegas01',
  'colapinto': 'fracol01',
  'bearman': 'olibea01',
  'bortoleto': 'gabbor01',
  'hulkenberg': 'nichul01',
  'albon': 'alealb01',
  'sainz': 'carsai01',
  'alonso': 'feralo01',
  'stroll': 'lanstr01',
  'bottas': 'valbot01',
  'perez': 'serper01',
  'arvid_lindblad': 'arvlin01',
  'tsunoda': 'yuktsu01',
  'ocon': 'estoco01',
  'ryo_hirakawa': 'ryohir01',
  'rafael_camara': 'rafcam01',
};

const Map<String, DriverAsset> _extraDriverAssetsById = <String, DriverAsset>{
  'arvid_lindblad': DriverAsset(
    code: 'arvlin01',
    name: 'Arvid Lindblad',
    nameZh: '林德布拉德',
  ),
  'tsunoda': DriverAsset(
    code: 'yuktsu01',
    name: 'Yuki Tsunoda',
    nameZh: '角田裕毅',
  ),
  'ocon': DriverAsset(code: 'estoco01', name: 'Esteban Ocon', nameZh: '奥康'),
  'ryo_hirakawa': DriverAsset(
    code: 'ryohir01',
    name: 'Ryo Hirakawa',
    nameZh: '平川亮',
  ),
  'rafael_camara': DriverAsset(
    code: 'rafcam01',
    name: 'Rafael Camara',
    nameZh: '卡马拉',
  ),
};

/// 未知车队（接口新增或改名）返回灰色兜底，UI 不会因此崩溃。
TeamAsset teamAssetFor(String constructorId) {
  final found = _teamAssetsById[constructorId];
  if (found != null) return found;
  return TeamAsset(
    id: constructorId,
    slug: constructorId,
    name: constructorId,
    nameZh: constructorId,
    colorHex: 0xFF9E9E9E,
    drivers: const <DriverAsset>[],
  );
}

/// 将接口中的 driverId 映射为官方照片素材；未知车手沿用车队兜底头像。
DriverAsset? driverAssetFor(String driverId, String constructorId) {
  final team = teamAssetFor(constructorId);
  final code = _driverCodeById[driverId];
  if (code == null) return team.drivers.isEmpty ? null : team.drivers.first;
  final extra = _extraDriverAssetsById[driverId];
  if (extra != null) return extra;
  for (final driver in team.drivers) {
    if (driver.code == code) return driver;
  }
  return team.drivers.isEmpty ? null : team.drivers.first;
}
