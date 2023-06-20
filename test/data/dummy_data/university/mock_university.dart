import 'package:practical_test/data/model/university/university.dart';

class MockUniversity {
  static const UniversityModel expectedUniversityModel = UniversityModel(
    alphaTwoCode: AlphaTwoCode.ID,
    country: Country.INDONESIA,
    domains: [
      "testing.com",
    ],
    name: "University Model Test",
    stateProvince: "Test",
    webPages: [
      "http://testing.com/"
    ]
  );

  static final Map<String, dynamic> expectedResponseModel = expectedUniversityModel.toJson();
}
