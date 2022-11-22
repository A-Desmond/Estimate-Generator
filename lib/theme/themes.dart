import 'package:estimate/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSettings {
  state({
    required WidgetRef ref,
  }) {
    final themeState = ref.watch(themeProvider);
    final style = TextStyle(
        color: themeState ? Colors.white : Colors.black, fontSize: 20);

    ///if true = render white
    final themedata = ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: themeState ? Colors.black : Colors.grey,
          titleTextStyle: style),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: style,
            minimumSize: const Size(300, 50),
            backgroundColor: themeState ? Colors.brown : Colors.black),
      ),
      scaffoldBackgroundColor: themeState ? Colors.grey[400] : Colors.white,
      dialogTheme: DialogTheme(
        backgroundColor: themeState ? Colors.grey[700] : Colors.white,
      ),
      cardColor: themeState ? Colors.white : Colors.grey,
    );

    return themedata;
  }
}

final themesettingsProvider = Provider((ref) => ThemeSettings());
