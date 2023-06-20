import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practical_test/data/repository/university/university.dart';
import 'package:practical_test/providers/university/university.dart';
import 'package:provider/provider.dart';
import 'package:practical_test/screens/route.dart' as route;
import 'package:practical_test/utils/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UniversityProvider(
            apiService: UniversityRepository(
              client: Dio(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchUniversityProvider(
            apiService: UniversityRepository(
              client: Dio(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Practical Test',
        theme: myThemeData,
        onGenerateRoute: route.controller,
        initialRoute: route.loginScreen,
      ),
    );
  }
}
