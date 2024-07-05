import '../../imports/index.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Style.colors.white,
  primaryColor: Style.colors.primary,
  splashColor: Style.colors.primary,
  highlightColor: Style.colors.primary,
  fontFamily: 'inter',
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(
        secondary: Style.colors.primary,
        primary: Style.colors.primary,
      )
      .copyWith(secondary: Style.colors.primary),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Style.colors.primary),
);