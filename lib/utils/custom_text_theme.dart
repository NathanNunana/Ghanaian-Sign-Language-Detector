part of bc_utils;

class CustomTextTheme {
  late TextTheme textTheme;

  static CustomTextTheme customTextTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dark(context)
        : light(context);
  }

  static CustomTextTheme light(BuildContext context) => CustomTextTheme()
    ..textTheme = TextTheme(
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          color: AppTheme.appTheme(context).dark,
          letterSpacing: .5,
        ),
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: AppTheme.appTheme(context).light,
          letterSpacing: -0.3,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          color: AppTheme.appTheme(context).light,
          letterSpacing: -0.3,
        ),
        labelSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: AppTheme.appTheme(context).danger,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: AppTheme.appTheme(context).success,
        ));
  static CustomTextTheme dark(BuildContext context) => CustomTextTheme()
    ..textTheme = TextTheme(
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppTheme.appTheme(context).dark,
        letterSpacing: -0.3,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppTheme.appTheme(context).dark,
        letterSpacing: -0.3,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: AppTheme.appTheme(context).dark,
        letterSpacing: -0.3,
      ),
    );
}
