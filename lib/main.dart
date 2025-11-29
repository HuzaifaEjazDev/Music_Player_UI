import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'viewmodels/player_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/library_viewmodel.dart';
import 'views/main_screen.dart';
import 'services/api_test.dart';
import 'services/api_debug.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => LibraryViewModel()),
      ],
      child: MaterialApp(
        title: 'Vibia',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
        routes: {
          '/api-test': (context) => ApiTestScreen(),
          '/api-debug': (context) => ApiDebugScreen(),
        },
      ),
    );
  }
}