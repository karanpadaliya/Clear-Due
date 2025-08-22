import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_inner_shadow.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class AppSupport extends StatelessWidget {
  AppSupport({super.key});

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      context.read<MyProfileBloc>().add(SearchFaqEvent(_searchController.text));
    });
    return Scaffold(
      appBar: const CustomAppbar(title: 'how_may_i_help_you', isKey: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VariableBag.screenHorizontalPadding,
          ),
          child: BlocBuilder<MyProfileBloc, MyProfileState>(
            builder: (context, state) {
              if (state is AppSupportDataLoadingState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search shimmer
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: .044 * Responsive.getHeight(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Category shimmer
                    SizedBox(
                      height: .030 * Responsive.getHeight(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: .016 * Responsive.getHeight(context)),

                    // FAQ shimmer list
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: 6,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  12 * Responsive.getResponsive(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state is FetchProfileDataErrorState) {
                return Center(
                  child: CustomText(
                    state.errorMessage,
                    color: AppTheme.getColor(context).error,
                    fontSize: 16 * Responsive.getResponsiveText(context),
                  ),
                );
              }
              if (state is AppSupportUiState) {
                return Column(
                  children: [
                    // SEARCH
                    CustomSearchField(
                      height: .044 * Responsive.getHeight(context),
                      hintText: 'search',
                      controller: _searchController,
                    ),
                    SizedBox(height: .016 * Responsive.getHeight(context)),

                    // CATEGORIES
                    SizedBox(
                      height: .030 * Responsive.getHeight(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          final isSelected = category == state.selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              context.read<MyProfileBloc>().add(
                                SelectFaqCategoryEvent(category),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    4 * Responsive.getResponsive(context),
                              ),
                              child: InnerShadowContainer(
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.transparent
                                      : AppTheme.getColor(context).primary,
                                ),
                                isShadowBottomLeft: isSelected,
                                backgroundColor: isSelected
                                    ? AppTheme.getColor(context).primary
                                    : AppColors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        22 * Responsive.getResponsive(context),
                                  ),
                                  child: CustomText(
                                    category,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        12 *
                                        Responsive.getResponsiveText(context),
                                    color: isSelected
                                        ? AppTheme.getColor(context).surface
                                        : AppTheme.getColor(context).primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: .016 * Responsive.getHeight(context)),

                    // FAQS
                    state.filteredFaqList.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: CustomText('No questions found.'),
                            ),
                          )
                        : Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getColor(context).surface,
                                borderRadius: BorderRadius.circular(
                                  12 * Responsive.getResponsive(context),
                                ),
                                border: Border.all(
                                  color: AppTheme.getColor(context).outline,
                                ),
                              ),
                              child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: state.filteredFaqList.length,
                                itemBuilder: (context, index) {
                                  final faq = state.filteredFaqList[index];
                                  final isExpanded = state.expandedFaqIndices
                                      .contains(index);
                                  final isLast =
                                      index == state.filteredFaqList.length - 1;
                                  return _expandableQnATile(
                                    context: context,
                                    index: index,
                                    question: faq.question,
                                    answer: faq.answer,
                                    isExpanded: isExpanded,
                                    isLast: isLast,
                                  );
                                },
                              ),
                            ),
                          ),
                    SizedBox(height: .010 * Responsive.getHeight(context)),
                  ],
                );
              }
              // loading spinner fallback
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _expandableQnATile({
    required BuildContext context,
    required int index,
    required String question,
    required String answer,
    required bool isExpanded,
    required bool isLast,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      InkWell(
        onTap: () {
          context.read<MyProfileBloc>().add(ToggleFaqExpandEvent(index));
          if (!isExpanded && isLast) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent + 100,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              );
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16 * Responsive.getResponsive(context),
            horizontal: 16 * Responsive.getResponsive(context),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  question,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onSurface,
                ),
              ),
              SizedBox(width: .005 * Responsive.getWidth(context)),
              AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: isExpanded ? 0.5 : 0,
                child: Icon(
                  Icons.expand_circle_down_outlined,
                  size: 20,
                  color: AppTheme.getColor(context).primary,
                ),
              ),
            ],
          ),
        ),
      ),
      if (isExpanded)
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  20 * Responsive.getResponsive(context),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                      12 * Responsive.getResponsive(context),
                    ),
                  ),
                  border: Border(
                    bottom: isLast
                        ? BorderSide.none
                        : BorderSide(color: AppTheme.getColor(context).outline),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * Responsive.getResponsive(context),
                  ),
                  child: CustomText(
                    answer,
                    fontSize: 14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                ),
              ),
              SizedBox(height: .010 * Responsive.getHeight(context)),
            ],
          ),
        ),
    ],
  );
}

// @override
// void initState() {
//   super.initState();
//   context.read<MyProfileBloc>().add(const FetchAppSupportEvent());
//   _searchController.addListener(() {
//     context.read<MyProfileBloc>().add(SearchFaqEvent(_searchController.text));
//   });
// }
//
// @override
// void dispose() {
//   _scrollController.dispose();
//   _searchController.dispose();
//   super.dispose();
// }
