import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/bloc/country_code_bloc.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/bloc/country_code_event.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/bloc/country_code_state.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/model/country_model.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

Future<CountryModel?> showCountryCodeBottomSheet({
  required BuildContext context,
  required String heading,
  String? selectedId,
  String? icon,
  String? searchHint,
  String? btnTitle,
}) => showModalBottomSheet<CountryModel?>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => BlocProvider(
    create: (context) => CountryCodeBloc(initialSelectedId: selectedId),
    child: _CustomCountryCodeBottomSheet(
      heading: heading,
      selectedId: selectedId,
      icon: icon,
      searchHint: searchHint,
      btnTitle: btnTitle,
    ),
  ),
);

class _CustomCountryCodeBottomSheet extends StatelessWidget {
  final String heading;
  final String? selectedId;
  final String? searchHint, btnTitle, icon;

  const _CustomCountryCodeBottomSheet({
    required this.heading,
    this.selectedId,
    this.searchHint,
    this.btnTitle,
    this.icon,
  });

  Widget _buildFlagIcon(dynamic flag, {double size = 24}) {
    if (flag == null) return const SizedBox.shrink();

    if (flag is String) {
      if (flag.startsWith('http')) {
        // Network image (PNG, JPG)
        return Image.network(
          flag,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(Icons.flag_outlined),
        );
      } else if (flag.endsWith('.svg')) {
        // SVG asset
        return SvgPicture.asset(flag, width: size, height: size);
      } else if (flag.endsWith('.png') || flag.endsWith('.jpg')) {
        // Local asset image
        return Image.asset(
          flag,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      } else {
        // Emoji flag or fallback text
        return Text(flag, style: TextStyle(fontSize: size));
      }
    }
    return const Icon(Icons.flag_outlined, size: 24);
  }

  @override
  Widget build(BuildContext context) {
    final countryCodeBloc = BlocProvider.of<CountryCodeBloc>(context);

    return Container(
      height: Responsive.getHeight(context) * 0.75,
      width: Responsive.getWidth(context),
      padding: EdgeInsets.only(
        top:
            VariableBag.bottomSheetTopPadding *
            Responsive.getResponsive(context),
        bottom:
            VariableBag.bottomSheetBottomPadding *
            Responsive.getResponsive(context),
        left:
            VariableBag.bottomSheetLeftPadding *
            Responsive.getResponsive(context),
        right:
            VariableBag.bottomSheetRightPadding *
            Responsive.getResponsive(context),
      ),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12 * Responsive.getResponsive(context)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Icon
          Row(
            children: [
              if (heading.isNotEmpty)
                Expanded(
                  child: CustomText(
                    LanguageManager().get(heading),
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).onSurface,
                  ),
                ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  icon ?? AppAssets.downArrowBottomSheet,
                  width: Responsive.isTablet(context)
                      ? 0.03 * Responsive.getWidth(context)
                      : 0.06 * Responsive.getWidth(context),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),

          SizedBox(
            height: Responsive.isTablet(context)
                ? 0.006 * Responsive.getHeight(context)
                : 0.009 * Responsive.getHeight(context),
          ),

          // Search field
          CustomSearchField(
            hintText: searchHint ?? 'search',
            onChanged: (query) {
              countryCodeBloc.add(SearchQueryChanged(query));
            },
          ),
          SizedBox(height: 12 * Responsive.getResponsive(context)),

          // List of items
          Expanded(
            child: BlocBuilder<CountryCodeBloc, CountryCodeState>(
              builder: (context, state) {
                if (state.filteredCountries.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                        16.0 * Responsive.getResponsive(context),
                      ),
                      child: CustomText(
                        'No matching results found',
                        fontSize: 16 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getColor(context).onSurface,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.filteredCountries.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredCountries[index];
                    final id = item.id;
                    final name = item.name ?? '';
                    final flag = item.flag ?? '';
                    final code = item.dialCode ?? '';
                    if (id == null || name.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final isSelected = id == state.selectedId;

                    final isLastItem =
                        index == state.filteredCountries.length - 1;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, item);
                        countryCodeBloc.add(CountrySelected(item));
                      },
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: Responsive.isTablet(context)
                                  ? 0.0 * Responsive.getWidth(context)
                                  : 0.02 * Responsive.getWidth(context),
                              vertical: 7,
                            ),
                            leading: _buildFlagIcon(flag),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                name,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                color: isSelected
                                    ? AppColors.textPrimary
                                    : AppTheme.getColor(context).onSurface,
                              ),
                            ),
                            trailing: CustomText(
                              code,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppTheme.getColor(context).onSurface,
                            ),
                          ),
                          if (!isLastItem)
                            Divider(
                              height: 0.001 * Responsive.getHeight(context),
                              indent: 10 * Responsive.getResponsive(context),
                              endIndent: 10 * Responsive.getResponsive(context),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 0.01 * Responsive.getHeight(context)),
          MyCoButton(
            title: LanguageManager().get(btnTitle ?? 'close'),
            boarderRadius: 50,
            height: Responsive.isTablet(context)
                ? 0.10 * Responsive.getHeight(context)
                : 0.05 * Responsive.getHeight(context),
            isShadowBottomLeft: true,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
