import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/model/country_model.dart';

abstract class CountryCodeEvent {}

class SearchQueryChanged extends CountryCodeEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class CountrySelected extends CountryCodeEvent {
  final CountryModel selectedCountry;

  CountrySelected(this.selectedCountry);
}
