// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'dart:convert';

List<UniversityModel> universityModelFromJson(String str) => List<UniversityModel>.from(json.decode(str).map((x) => UniversityModel.fromJson(x)));

String universityModelToJson(List<UniversityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<UniversityModel> universityModelFromJsonMethod(List<dynamic> json) {
  var data = json.map((e) => UniversityModel.fromJson(e)).toList();
  return data;
}

class UniversityModel extends Equatable{
    final Country? country;
    final AlphaTwoCode? alphaTwoCode;
    final String? name;
    final dynamic stateProvince;
    final List<String>? domains;
    final List<String>? webPages;

    const UniversityModel({
        this.country,
        this.alphaTwoCode,
        this.name,
        this.stateProvince,
        this.domains,
        this.webPages,
    });

    factory UniversityModel.fromJson(Map<String, dynamic> json) => UniversityModel(
        country: countryValues.map[json["country"]]!,
        alphaTwoCode: alphaTwoCodeValues.map[json["alpha_two_code"]]!,
        name: json["name"],
        stateProvince: json["state-province"],
        domains: json["domains"] == null ? [] : List<String>.from(json["domains"]!.map((x) => x)),
        webPages: json["web_pages"] == null ? [] : List<String>.from(json["web_pages"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "country": countryValues.reverse[country],
        "alpha_two_code": alphaTwoCodeValues.reverse[alphaTwoCode],
        "name": name,
        "state-province": stateProvince,
        "domains": domains == null ? [] : List<dynamic>.from(domains!.map((x) => x)),
        "web_pages": webPages == null ? [] : List<dynamic>.from(webPages!.map((x) => x)),
    };

    @override
    List<Object?> get props => [
      country,
      alphaTwoCode,
      name,
      stateProvince,
      domains,
      webPages,
    ];
}

enum AlphaTwoCode { ID }

final alphaTwoCodeValues = EnumValues({
    "ID": AlphaTwoCode.ID
});

enum Country { INDONESIA }

final countryValues = EnumValues({
    "Indonesia": Country.INDONESIA
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
