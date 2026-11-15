import 'package:flutter/material.dart';

/// 设计 token：底色、卡片、分割线、强调色、文字层级。
///
/// 强调色固定为 Windows 蓝 #0067C0（深色模式提亮为 #4C9BE8 保证可读），
/// 全 App 只用这一个强调色，不再混入第二个品牌色。
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.canvas,
    required this.card,
    required this.cardElevated,
    required this.divider,
    required this.accent,
    required this.accentSoft,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.cardShadow,
    required this.isDark,
  });

  final Color canvas;
  final Color card;
  final Color cardElevated;
  final Color divider;
  final Color accent;
  final Color accentSoft;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color cardShadow;
  final bool isDark;

  static const Color accentSeed = Color(0xFF0067C0);

  static const AppPalette light = AppPalette(
    canvas: Color(0xFFF3F3F3),
    card: Color(0xFFFFFFFF),
    cardElevated: Color(0xFFFFFFFF),
    divider: Color(0xFFE5E5E5),
    accent: Color(0xFF0067C0),
    accentSoft: Color(0xFFE8F1FA),
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6B6B6B),
    textTertiary: Color(0xFF9A9A9A),
    cardShadow: Color(0x0F000000),
    isDark: false,
  );

  static const AppPalette dark = AppPalette(
    canvas: Color(0xFF1F1F1F),
    card: Color(0xFF2B2B2B),
    cardElevated: Color(0xFF323232),
    divider: Color(0xFF3C3C3C),
    accent: Color(0xFF4C9BE8),
    accentSoft: Color(0xFF21384D),
    textPrimary: Color(0xFFF2F2F2),
    textSecondary: Color(0xFFA8A8A8),
    textTertiary: Color(0xFF7A7A7A),
    cardShadow: Color(0x33000000),
    isDark: true,
  );

  @override
  AppPalette copyWith({
    Color? canvas,
    Color? card,
    Color? cardElevated,
    Color? divider,
    Color? accent,
    Color? accentSoft,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? cardShadow,
    bool? isDark,
  }) {
    return AppPalette(
      canvas: canvas ?? this.canvas,
      card: card ?? this.card,
      cardElevated: cardElevated ?? this.cardElevated,
      divider: divider ?? this.divider,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      cardShadow: cardShadow ?? this.cardShadow,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardElevated: Color.lerp(cardElevated, other.cardElevated, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}

extension AppThemeX on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// 全 App 统一的卡片外观：白底、12 圆角、极淡阴影。
  BoxDecoration cardDecoration({double radius = 12, Color? background}) {
    return BoxDecoration(
      color: background ?? palette.card,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: palette.cardShadow,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }
}

const FontFeature _tabularFigures = FontFeature.tabularFigures();

ThemeData buildAppTheme(Brightness brightness) {
  final palette = brightness == Brightness.dark ? AppPalette.dark : AppPalette.light;
  final scheme = ColorScheme.fromSeed(
    seedColor: AppPalette.accentSeed,
    brightness: brightness,
  ).copyWith(
    primary: palette.accent,
    surface: palette.card,
    onSurface: palette.textPrimary,
    outlineVariant: palette.divider,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: palette.canvas,
    fontFamily: 'Roboto',
    splashFactory: InkSparkle.splashFactory,
  );

  TextStyle style(
    double size,
    FontWeight weight,
    Color color, {
    double? height,
    double? letterSpacing,
    bool tabular = false,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      fontFeatures: tabular ? const <FontFeature>[_tabularFigures] : null,
    );
  }

  return base.copyWith(
    extensions: <ThemeExtension<dynamic>>[palette],
    textTheme: base.textTheme.copyWith(
      // 32：大数字（积分、倒计时天数）
      displaySmall: style(32, FontWeight.w600, palette.textPrimary,
          height: 1.1, letterSpacing: -0.6, tabular: true),
      // 20：标题
      titleLarge: style(20, FontWeight.w600, palette.textPrimary, height: 1.3),
      // 15：正文
      bodyMedium: style(15, FontWeight.w400, palette.textPrimary, height: 1.45),
      bodySmall: style(15, FontWeight.w400, palette.textSecondary, height: 1.45),
      // 12：辅助
      labelSmall: style(12, FontWeight.w500, palette.textTertiary,
          height: 1.3, letterSpacing: 0.2),
      labelMedium: style(12, FontWeight.w600, palette.textSecondary,
          height: 1.3, letterSpacing: 0.6),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: palette.card,
      elevation: 0,
      height: 64,
      indicatorColor: palette.accentSoft,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return style(
          12,
          selected ? FontWeight.w600 : FontWeight.w500,
          selected ? palette.accent : palette.textTertiary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          size: 22,
          color: selected ? palette.accent : palette.textTertiary,
        );
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.canvas,
      surfaceTintColor: Colors.transparent,
      foregroundColor: palette.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    dividerColor: palette.divider,
    dividerTheme: DividerThemeData(
      color: palette.divider,
      thickness: 1,
      space: 1,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: palette.accent,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: palette.textPrimary,
      contentTextStyle: TextStyle(color: palette.card, fontSize: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}