import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_section.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MomentsSection extends StatelessWidget {
  final List<EventAlbumEntity>? events;
  const MomentsSection({required this.events, super.key});

  @override
  Widget build(BuildContext context) {
    if (events?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return CustomSection(
      title: 'moments_that_matters',
      subtitle: 'live_the_moments_again',
      icon: Image.asset(
        AppAssets.quickAccessGif,
        height: 32 * Responsive.getDashboardResponsiveText(context),
      ),
      count: events?.length.toString().padLeft(2, '0') ?? '0',
      hasViewMoreButton: true,
      onViewMore: () => context.push(RoutePaths.gallery),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              events
                  ?.map(
                    (event) => GestureDetector(
                      onTap: () {
                        context.push(
                          RoutePaths.albumView,
                          extra: {
                            'albumName': event.albumTitle ?? '',
                            'galleryAlbumId': event.galleryAlbumId ?? '',
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: VariableBag.commonCardHorizontalPadding,
                        ),
                        child: BorderContainerWraper(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // spacing:
                            //     12 * Responsive.getDashboardResponsive(context),
                            children: [
                              CustomCachedNetworkImage(
                                imageUrl: event.imageOne ?? '',
                                height:
                                    200 *
                                    Responsive.getDashboardResponsive(context),
                                width:
                                    325 *
                                    Responsive.getDashboardResponsive(context),
                                errorWidget: Image.asset(AppAssets.myCoLogo),
                              ),
                              SizedBox(
                                height:
                                    12 *
                                    Responsive.getDashboardResponsive(context),
                              ),
                              CustomText(
                                event.albumTitle ?? '',
                                fontSize:
                                    14 *
                                    Responsive.getDashboardResponsiveText(
                                      context,
                                    ),
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              CustomText(
                                event.eventDate ?? '',
                                fontSize:
                                    13 *
                                    Responsive.getDashboardResponsiveText(
                                      context,
                                    ),
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
