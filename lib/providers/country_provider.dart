import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:splitbuddy/dtos/country_data.dart';

class CountryProvider extends ChangeNotifier {
  List<CountryData> _countries = [];

  List<CountryData> get countries => _countries;

  void addAllCountries(String countries) {
    List<CountryData> response = List<CountryData>.from(
        jsonDecode(countries)['countries']
            .map((model) => CountryData.fromJson(model)));
    _countries = response;
    notifyListeners();
  }
}
