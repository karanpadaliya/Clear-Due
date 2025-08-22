import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/utils/country_codes.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/bloc/country_code_event.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/bloc/country_code_state.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/model/country_model.dart';

class CountryCodeBloc extends Bloc<CountryCodeEvent, CountryCodeState> {
  final dynamic initialSelectedId;

  List<CountryModel> _allCountryCodes = [];

  CountryCodeBloc({this.initialSelectedId})
    : super(
        CountryCodeInitial(
          filteredCountries: [],
          selectedId: initialSelectedId is String ? initialSelectedId : null,
        ),
      ) {
    _allCountryCodes = countryCodesWithFlags
        .map(CountryModel.fromJson)
        .toList();

    emit(
      CountryCodeInitial(
        filteredCountries: List.from(_allCountryCodes),
        selectedId: initialSelectedId is String ? initialSelectedId : null,
      ),
    );

    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<CountrySelected>(_onCountrySelected);
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<CountryCodeState> emit,
  ) {
    final query = event.query.toLowerCase();

    final newFilteredList = _allCountryCodes.where((item) {
      final name = (item.name ?? '').toLowerCase();
      final code = (item.dialCode ?? '').toLowerCase();

      return name.contains(query) || code.contains(query);
    }).toList();
    emit(
      CountryCodeLoaded(
        filteredCountries: newFilteredList,
        selectedId: state.selectedId,
        searchQuery: event.query,
      ),
    );
  }

  void _onCountrySelected(
    CountrySelected event,
    Emitter<CountryCodeState> emit,
  ) {
    //
  }
}
