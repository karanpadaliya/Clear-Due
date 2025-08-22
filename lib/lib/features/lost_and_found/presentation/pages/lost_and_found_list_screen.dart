import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_event.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_state.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_inner_shadow.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/floating_action_btn.dart';

enum LostFoundFilter { all, lost, found }

class LostAndFoundListScreen extends StatefulWidget {
  const LostAndFoundListScreen({super.key});

  @override
  State<LostAndFoundListScreen> createState() => _LostAndFoundListScreenState();
}

class _LostAndFoundListScreenState extends State<LostAndFoundListScreen> {
  String _searchQuery = '';
  LostFoundFilter _selectedFilter = LostFoundFilter.all;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    context.read<LostAndFoundBloc>().add(
      GetLostAndFoundItemsEvent(await _buildRequest()),
    );
  }

  Future<Map<String, String?>> _buildRequest() async {
    final preferenceManager = GetIt.I<PreferenceManager>();

    final companyId = await preferenceManager.getCompanyId();
    final userId = await preferenceManager.getUserId();
    final languageId = await preferenceManager.getLanguageId();

    return {
      'getListNew': 'getListNew',
      'society_id': companyId?.toString(),
      'user_id': userId?.toString(),
      'language_id': languageId?.toString(),
      'lost_found_master_id': '',
      'is_details_view': '0',
    };
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final height = Responsive.getHeight(context);
    final width = Responsive.getWidth(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'lost_found',
        centerTitle: false,
        elevation: 0,
        isKey: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28 * responsive),
        child: Column(
          children: [
            CustomSearchField(
              hintText: 'search',
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            SizedBox(height: 0.020 * height),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildButton(
                    context,
                    title: 'ALL',
                    isSelected: _selectedFilter == LostFoundFilter.all,
                    onTap: () {
                      setState(() {
                        _selectedFilter = LostFoundFilter.all;
                      });
                    },
                  ),
                  SizedBox(width: 0.02 * width),
                  _buildButton(
                    context,
                    title: 'LOST',
                    isSelected: _selectedFilter == LostFoundFilter.lost,
                    onTap: () {
                      setState(() {
                        _selectedFilter = LostFoundFilter.lost;
                      });
                    },
                  ),
                  SizedBox(width: 0.02 * width),
                  _buildButton(
                    context,
                    title: 'FOUND',
                    isSelected: _selectedFilter == LostFoundFilter.found,
                    onTap: () {
                      setState(() {
                        _selectedFilter = LostFoundFilter.found;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.020 * height),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadInitialData,
                child: BlocBuilder<LostAndFoundBloc, LostAndFoundState>(
                  builder: (context, state) {
                    if (state is LostAndFoundLoading) {
                      return const CustomLoader();
                    }
                    if (state is LostAndFoundError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is LostAndFoundLoaded) {
                      return _buildGrid(state.items, responsive, height, width);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color bgColor = isSelected
        ? AppTheme.getColor(context).primary
        : AppTheme.getColor(context).onInverseSurface;

    final Color textColor = isSelected
        ? AppTheme.getColor(context).onInverseSurface
        : AppTheme.getColor(context).onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppTheme.getColor(context).primary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14 * Responsive.getResponsiveText(context),
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(
    List items,
    double responsive,
    double height,
    double width,
  ) {
    List filteredItems = items;

    // Apply filter: Lost, Found, All
    if (_selectedFilter == LostFoundFilter.lost) {
      filteredItems = filteredItems
          .where((item) => item.lostFoundTypeInt == '1')
          .toList();
    } else if (_selectedFilter == LostFoundFilter.found) {
      filteredItems = filteredItems
          .where((item) => item.lostFoundTypeInt == '0')
          .toList();
    }

    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where(
            (item) =>
                item.lostFoundTitle?.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ??
                false,
          )
          .toList();
    }

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No items found.'));
    }

    return GridView.builder(
      itemCount: filteredItems.length,
      padding: const EdgeInsets.only(bottom: 70),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) =>
          _buildItem(filteredItems[index], responsive, height, width),
    );
  }

  Widget _buildItem(item, double responsive, double height, double width) {
    final isFound = item.lostFoundTypeInt == '0';
    final statusLabel = isFound ? 'Found' : 'Lost';
    final statusColor = isFound
        ? AppTheme.getColor(context).secondary
        : AppTheme.getColor(context).error;

    final formattedDate = DateFormat(
      'dd MMM yyyy (EEE)',
    ).format(DateTime.tryParse(item.lostFoundDate ?? '') ?? DateTime.now());

    return GestureDetector(
      onTap: () async {
        final result = await context.pushNamed(
          RoutePaths.lostAndFoundItemDetails,
          extra: item,
        );
        if (result == 'refresh') _loadInitialData();
      },
      child: Container(
        height: 0.150 * height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary, width: 0.003 * width),
          color: AppTheme.isAppThemeDarkMode(context)
              ? AppColors.containerHighDark
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.getColor(context).onInverseSurface,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 0.120 * height,
                    width: double.infinity,
                    child: CustomCachedNetworkImage(
                      imageUrl: item.lostFoundImage ?? '',
                      errorWidget: Image.asset(AppAssets.myCoLogo),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InnerShadowContainer(
                      backgroundColor: statusColor,
                      height: 0.02 * height,
                      width: 0.1 * width,
                      borderRadius: 50,
                      isShadowBottomLeft: true,
                      child: CustomText(
                        statusLabel,
                        fontSize: 10 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                        color: AppTheme.getColor(context).onInverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 8, 3),
              child: CustomText(
                item.lostFoundTitle ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
                fontSize: 16 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 8, 5),
              child: CustomText(
                formattedDate,
                fontSize: 10 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() => ExpandableFab(
    innericonsize: 30 * Responsive.getResponsive(context),
    imageSize: 50 * Responsive.getResponsive(context),
    onTap: () async {
      final result = await context.pushNamed(RoutePaths.lostAndFoundAddScreen);
      if (result == 'refresh') _loadInitialData();
    },
    openIcon: Icons.add,
    closeIcon: Icons.close,
    actions: const [],
  );
}
