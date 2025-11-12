import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/app/di/app_injector.dart';
import 'package:news_app/features/news_list/1_presentation/screens/news_list_screen.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjector.setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NewsListScreen(),
    );
  }
}
