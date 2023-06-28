import 'package:core_ui/core_ui.dart';

final ThemeData myTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: ApplicationColors.primaryColor,
  primaryColorLight: ApplicationColors.primaryColorLight,
  primaryColorDark: ApplicationColors.primaryColorDark,
  canvasColor: ApplicationColors.canvasColor,
  scaffoldBackgroundColor: ApplicationColors.scaffoldBackgroundColor,
  cardColor: ApplicationColors.white,
  dividerColor: ApplicationColors.dividerColor,
  highlightColor: ApplicationColors.highlightColor,
  splashColor: ApplicationColors.splashColor,
  unselectedWidgetColor: ApplicationColors.unselectedWidgetColor,
  disabledColor: ApplicationColors.disabledColor,
  secondaryHeaderColor: ApplicationColors.secondaryHeaderColor,
  dialogBackgroundColor: ApplicationColors.disabledColor,
  indicatorColor: ApplicationColors.indicatorColor,
  hintColor: ApplicationColors.hintColor,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: ApplicationSize.SIZE_88,
    height: ApplicationSize.SIZE_36,
    padding: const EdgeInsets.only(
        top: ApplicationSize.SIZE_0,
        bottom: ApplicationSize.SIZE_0,
        left: ApplicationSize.SIZE_16,
        right: ApplicationSize.SIZE_16),
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: ApplicationColors.primaryColor,
        width: ApplicationSize.SIZE_0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(ApplicationSize.SIZE_2),
      ),
    ),
    alignedDropdown: false,
    buttonColor: ApplicationColors.buttonColor,
    disabledColor: ApplicationColors.primaryColor,
    highlightColor: ApplicationColors.primaryColor,
    splashColor: ApplicationColors.primaryColor,
    focusColor: ApplicationColors.primaryColor,
    hoverColor: ApplicationColors.primaryColor,
    colorScheme: ColorScheme(
      primary: ApplicationColors.primaryColor,
      secondary: ApplicationColors.red,
      surface: ApplicationColors.white,
      background: ApplicationColors.primaryColorLight,
      error: ApplicationColors.red,
      onPrimary: ApplicationColors.white,
      onSecondary: ApplicationColors.white,
      onSurface: ApplicationColors.primaryColor,
      onBackground: ApplicationColors.white,
      onError: ApplicationColors.white,
      brightness: Brightness.light,
    ),
  ),
);
