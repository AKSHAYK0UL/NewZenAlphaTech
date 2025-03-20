import 'package:flutter/material.dart';

ThemeData theme(BuildContext context) {
  final screenSize = MediaQuery.sizeOf(context);
  return ThemeData(
    primaryColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      primary: Colors.black,
      secondary: Colors.grey,
    ),
    hintColor: Colors.white,
    splashColor: Colors.grey,
    canvasColor: Colors.white,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      scrolledUnderElevation: 0,
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0333,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0287,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.024,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0333,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0287,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.024,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0230,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0207,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0187,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0467,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.0430,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.020,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.026,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: screenSize.height * 0.023,
        fontWeight: FontWeight.w500,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.blueGrey.shade200,
      selectionColor: Colors.blueGrey.shade200,
      selectionHandleColor: Colors.blueGrey.shade300,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          screenSize.height * 1,
          screenSize.height * 0.0747,
        ),
        disabledBackgroundColor: Colors.grey.shade600,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade200, // override for FAB
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );
}
