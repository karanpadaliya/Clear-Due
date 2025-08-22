import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_shadow_container.dart';
import 'package:shimmer/shimmer.dart';

class MenuSelectionBottomSheet extends StatelessWidget {
  final List<AppMenuEntity> items;

  const MenuSelectionBottomSheet({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No suggestions found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close bottom sheet
            print('Navigate to: ${item.menuClick}');
            // Uncomment to dispatch BLoC event:
            // context.read<SpeechBloc>().add(
            //   SpeechNavigateToMenuEvent(menuItem: item),
            // );
          },
          child: Column(
            children: [
              BorderContainerWraper(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: CustomShadowContainer(
                  title: item.menuLanguageKey ?? '',
                  imgTitleSpacing: 10,
                  width: 0.2 * Responsive.getWidth(context),
                  boxPadding: 1 * Responsive.getDashboardResponsive(context),
                  imagePadding: 20 * Responsive.getDashboardResponsive(context),
                  // imgTitleSpacing: 0,
                  image: CachedNetworkImage(
                    imageUrl: item.menuIcon ?? '',

                    // height: height,
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
                  ), // Replace with actual image if needed
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
