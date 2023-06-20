import 'package:flutter_test/flutter_test.dart';
import 'package:practical_test/data/model/university/university.dart';
import '../../dummy_data/university/mock_university.dart';

void main() {
  group("Test UniversityModel initialization from json", () {
    late Map<String, dynamic> apiUniversityAsJson;
    late UniversityModel expectedApiUniversity;

    setUp(() {
      apiUniversityAsJson = MockUniversity.expectedResponseModel;
      expectedApiUniversity = MockUniversity.expectedUniversityModel;
    });

    test('should be an University Model', () {
      //act
      var result = UniversityModel.fromJson(apiUniversityAsJson);
      //assert
      expect(result, isA<UniversityModel>());
    });

    test('should not be null', () {
      //act
      var result = UniversityModel.fromJson(apiUniversityAsJson);
      //assert
      expect(result, isNotNull);
    });

    test('result should be as expected', () {
      //act
      var result = UniversityModel.fromJson(apiUniversityAsJson);
      //assert
      expect(result, expectedApiUniversity);
    });
  });
}
