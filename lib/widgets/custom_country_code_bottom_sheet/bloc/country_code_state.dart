import 'package:flutter/foundation.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/model/country_model.dart';

abstract class CountryCodeState {
  final List<CountryModel> filteredCountries;
  final String? selectedId;
  final String searchQuery;

  CountryCodeState({
    required this.filteredCountries,
    this.selectedId,
    this.searchQuery = '',
  });
}

class CountryCodeInitial extends CountryCodeState {
  CountryCodeInitial({required super.filteredCountries, super.selectedId});
}

class CountryCodeLoaded extends CountryCodeState {
  CountryCodeLoaded({
    required super.filteredCountries,
    super.selectedId,
    super.searchQuery,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryCodeLoaded &&
        listEquals(filteredCountries, other.filteredCountries) &&
        selectedId == other.selectedId &&
        searchQuery == other.searchQuery;
  }

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(filteredCountries), selectedId, searchQuery);
}
