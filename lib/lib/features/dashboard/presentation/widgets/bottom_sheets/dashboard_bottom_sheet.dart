import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/di/injector.dart'; // Ensure your BLoC is registered here
import 'package:myco_flutter/features/home_screen/bloc/home_screen_bloc/home_menu_bloc.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_shadow_container.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

/// A self-contained bottom sheet that displays menu items, managed by HomeMenuBloc.
class AnimatedBottomSheet extends StatelessWidget {
  const AnimatedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    // This creates and provides the BLoC to the widget subtree.
    // Ensure HomeMenuBloc is registered with your service locator (sl).
    create: (context) => sl<HomeMenuBloc>()..add(HomeMenuFetched()),
    child: const _AnimatedBottomSheetView(),
  );
}

/// The view part of the bottom sheet, which is a stateful widget
/// to manage UI-only state like controllers and animations.
class _AnimatedBottomSheetView extends StatefulWidget {
  const _AnimatedBottomSheetView();

  @override
  State<_AnimatedBottomSheetView> createState() =>
      _AnimatedBottomSheetViewState();
}

class _AnimatedBottomSheetViewState extends State<_AnimatedBottomSheetView> {
  // UI-specific state that does not belong in the BLoC.
  final Set<String> _animatedCategories = {};
  late final TextEditingController _searchController;
  late final ValueNotifier<double> _scrollNotifier;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollNotifier = ValueNotifier<double>(0.0);

    _searchController.addListener(() {
      // Dispatch search events to the BLoC as the user types.
      context.read<HomeMenuBloc>().add(
        HomeMenuSearchChanged(_searchController.text),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.7,
    minChildSize: 0.5,
    maxChildSize: 0.92,
    expand: false,
    builder: (BuildContext context, ScrollController scrollController) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VariableBag.screenHorizontalPadding,
          ),
          child: Column(
            children: [
              // Draggable handle indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Search Field
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CustomSearchField(
                  controller: _searchController,
                  hintText: 'what_you_looking_for',
                  height: Responsive.getDashboardResponsive(context) * 50,
                ),
              ),
              // Content area that rebuilds based on BLoC state
              Expanded(
                child: BlocBuilder<HomeMenuBloc, HomeMenuState>(
                  builder: (context, state) {
                    if (state is HomeMenuLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeMenuError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is HomeMenuLoaded) {
                      final filteredCategories = state.filteredCategories;
                      final filteredCategorizedMenu =
                          state.filteredItemsGrouped;

                      if (filteredCategories.isEmpty &&
                          state.searchQuery.isNotEmpty) {
                        return const Center(child: Text('No services found.'));
                      }

                      return NotificationListener<ScrollUpdateNotification>(
                        onNotification: (notification) {
                          _scrollNotifier.value = notification.metrics.pixels;
                          return false;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          itemCount: filteredCategories.length,
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast,
                          ),
                          itemBuilder: (context, index) {
                            final category = filteredCategories[index];
                            final categoryId = category.menuCategoryId;
                            final items =
                                filteredCategorizedMenu[categoryId] ?? [];

                            if (items.isEmpty || categoryId == null) {
                              return const SizedBox.shrink();
                            }

                            final bool hasAnimated = _animatedCategories
                                .contains(categoryId);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: VariableBag.commonCardVerticalPadding,
                                ),
                                AnimatedCategoryTitle(
                                  title:
                                      category.menuCategoryName ??
                                      'Unnamed Category',
                                  icon: category.menuCategoryIcon ?? '',
                                  hasAnimated: hasAnimated,
                                  isFirstItem: index == 0,
                                  scrollNotifier: _scrollNotifier,
                                  onAnimationComplete: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          if (mounted) {
                                            setState(() {
                                              _animatedCategories.add(
                                                categoryId,
                                              );
                                            });
                                          }
                                        });
                                  },
                                ),
                                const SizedBox(
                                  height: VariableBag.commonCardVerticalPadding,
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            Responsive.getGridConfig(
                                              context,
                                              screenWide: constraints.maxWidth,
                                            ).itemCount,
                                        crossAxisSpacing:
                                            Responsive.getGridConfig(
                                              context,
                                              screenWide: constraints.maxWidth,
                                            ).spacing,
                                        mainAxisSpacing:
                                            Responsive.getGridConfig(
                                              context,
                                              screenWide: constraints.maxWidth,
                                            ).spacing,
                                        childAspectRatio:
                                            Responsive.getGridConfig(
                                              context,
                                              screenWide: constraints.maxWidth,
                                            ).childAspectRatio,
                                      ),
                                  itemCount: items.length,
                                  itemBuilder: (context, gridIndex) {
                                    final menuItem = items[gridIndex];
                                    return InkWell(
                                      onTap: () {
                                        if (menuItem.iosMenuClick != null &&
                                            menuItem.iosMenuClick!.isNotEmpty) {
                                          context.pushNamed(
                                            menuItem.iosMenuClick!,
                                          );
                                        }
                                      },
                                      child: BorderContainerWraper(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: CustomShadowContainer(
                                          title: menuItem.menuTitle ?? '',
                                          boxPadding:
                                              0 *
                                              Responsive.getDashboardResponsive(
                                                context,
                                              ),
                                          imagePadding:
                                              20 *
                                              Responsive.getDashboardResponsive(
                                                context,
                                              ),
                                          image: CachedNetworkImage(
                                            imageUrl: menuItem.menuIcon ?? '',
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    width: 28,
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                      'assets/images/logo.png',
                                                    ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    // Return a default widget for the initial state.
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // child: ,
    ),
  );
}

/// This widget remains unchanged as its logic is purely for UI animation
/// and is self-contained.
class AnimatedCategoryTitle extends StatefulWidget {
  final String title;
  final String icon;
  final bool hasAnimated;
  final bool isFirstItem;
  final VoidCallback onAnimationComplete;
  final ValueNotifier<double> scrollNotifier;

  const AnimatedCategoryTitle({
    required this.title,
    required this.icon,
    required this.hasAnimated,
    required this.isFirstItem,
    required this.onAnimationComplete,
    required this.scrollNotifier,
    super.key,
  });

  @override
  State<AnimatedCategoryTitle> createState() => _AnimatedCategoryTitleState();
}

class _AnimatedCategoryTitleState extends State<AnimatedCategoryTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool get _shouldAnimate => !widget.hasAnimated;

  @override
  void initState() {
    super.initState();
    if (_shouldAnimate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onAnimationComplete();
          widget.scrollNotifier.removeListener(_checkVisibilityAndAnimate);
        }
      });

      if (widget.isFirstItem) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _controller.forward(),
        );
      } else {
        widget.scrollNotifier.addListener(_checkVisibilityAndAnimate);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _checkVisibilityAndAnimate(),
        );
      }
    }
  }

  void _checkVisibilityAndAnimate() {
    if (!mounted ||
        !_shouldAnimate ||
        _controller.isAnimating ||
        _controller.status == AnimationStatus.completed) {
      return;
    }

    final RenderObject? object = context.findRenderObject();
    if (object == null || !object.attached) {
      return;
    }

    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
    final ScrollableState scrollable = Scrollable.of(context);

    final position = scrollable.position;
    final double widgetTopOffset = viewport
        .getOffsetToReveal(object, 0.0)
        .offset;
    final double widgetBottomOffset = viewport
        .getOffsetToReveal(object, 1.0)
        .offset;

    if (widgetTopOffset < position.pixels + position.viewportDimension &&
        widgetBottomOffset > position.pixels) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (_shouldAnimate) {
      widget.scrollNotifier.removeListener(_checkVisibilityAndAnimate);
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final finalWidget = Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              widget.title,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppTheme.getColor(context).onSecondary,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                8 * Responsive.getResponsive(context),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.icon,
                height: 40 * Responsive.getResponsive(context),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/logo.png'),
              ),
            ),
          ],
        ),
      ),
    );

    if (!_shouldAnimate) {
      return finalWidget;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: finalWidget,
      ),
    );
  }
}
