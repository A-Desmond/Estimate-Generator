import 'package:estimate/home.dart';

import 'package:estimate/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Everlasting shop',
        theme: ref.watch(themesettingsProvider).state(ref: ref),
        themeMode: ThemeMode.system,
        home: const HomePage());
  }
}
