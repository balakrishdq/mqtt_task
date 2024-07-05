import '../../imports/index.dart';

class CustomTextStyle {
  TextStyle primary({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    List<FontFeature>? fontFeatures,
    Color? decorationColor,
    Paint? foreground,
    Locale? locale,
  }) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      fontFeatures: fontFeatures,
      foreground: foreground,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      locale: locale,
    );
  }
}
