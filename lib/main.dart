import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shoes_shop_app/constant/app_theme.dart';
import 'package:shoes_shop_app/views/app_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shoes App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppNavigationBar(),
      // home: const LoginPage()
    );
  }
}
