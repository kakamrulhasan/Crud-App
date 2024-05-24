import 'package:flutter/material.dart';
import 'package:flutter_application_36/product_list_screen.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _lightThemeData(),
        darkTheme: _DarkThemeData(),
        themeMode: ThemeMode.system,
        home: ProductListScreen());
  }

  ThemeData _lightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.red[800]),
            ));
        
  }
  ThemeData _DarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite),
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.red[800]),
            ));
        
  }
}
