import 'package:flutter/material.dart';
import 'package:practical_test/screens/auth/login.dart';
import 'package:practical_test/screens/detail/detail.dart';
import 'package:practical_test/screens/home/home.dart';
import 'package:practical_test/screens/search/search.dart';

const loginScreen = 'login_screen';
const homeScreen = 'home_screen';
const detailScreen = 'detail_screen';
const searchScreen = 'search_screen';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginScreen:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case detailScreen:
      return MaterialPageRoute(
        builder: (context) => const DetailScreen(),
      );
    case searchScreen:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    default:
      throw ('Page is not found!');
  }
}