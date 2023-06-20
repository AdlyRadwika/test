import 'package:flutter/material.dart';
import 'package:practical_test/data/repository/university/university.dart';
import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/utils/provider_enum.dart';

late List<UniversityModel> _university;
late List<UniversityModel> _universitySearch;
late UniversityModel _detail;
late ProviderState _state;
late ProviderState _searchState;
String _message = '';

class UniversityProvider extends ChangeNotifier {
  final UniversityRepository apiService;

  UniversityProvider({
    required this.apiService,
  }) {
    fetchUniversityList();
  }

  String get message => _message;

  List<UniversityModel> get university => _university;

  List<UniversityModel> get universitySearch => _universitySearch;

  UniversityModel get detail => _detail;

  ProviderState get state => _state;

  ProviderState get searchState => _searchState;

  void getUniversityDetail({required UniversityModel data}) {
    _detail = data;
    notifyListeners();
  }

  Future<void> fetchUniversityList() async {
    try {
      _state = ProviderState.loading; 
      notifyListeners();
      final university = await apiService.getUniversityList();
      if (university.isEmpty) {
        _state = ProviderState.empty;
        _message = 'The list is empty';
      } else {
        _state = ProviderState.loaded;
        _university = university;
      }
      notifyListeners();
    } catch (e) {
      _state = ProviderState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<List<UniversityModel>?> fetchMoreUniversityList({required int pageKey}) async {
    try {
      final university = await apiService.getUniversityList(page: pageKey);
      if (university.isEmpty) {
        _message = 'The list is empty';
      } else {
        _state = ProviderState.loaded;
        return university;
      }
      return [];
    } catch (e) {
      _message = e.toString();
      return [];
    }
  }
}

class SearchUniversityProvider extends ChangeNotifier {
  final UniversityRepository apiService;

  SearchUniversityProvider({
    required this.apiService,
  }) {
    searchUniversityList(query: '', pageKey: 0);
  }

  String get message => _message;


  List<UniversityModel> get universitySearch => _universitySearch;

  UniversityModel get detail => _detail;

  ProviderState get searchState => _searchState;

  void getUniversityDetail({required UniversityModel data}) {
    _detail = data;
    notifyListeners();
  }

  Future<dynamic> searchUniversityList({int pageKey = 0, required String query}) async {
    try {
      _searchState = ProviderState.loading; 
      notifyListeners();
      final result = await apiService.searchUniversity(query: query, page: pageKey);
      if (result.isEmpty) {
        _searchState = ProviderState.empty;
        _message = 'The list is empty';
      } else {
        _searchState = ProviderState.loaded;
        return _universitySearch = result;
      }
      notifyListeners();
    } catch (e) {
      _searchState = ProviderState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  searchTheUniversity(String query) {
    searchUniversityList(query: query);
    notifyListeners();
  }
}