import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/gallery/gallery_bloc.dart';
import 'package:myco_flutter/features/gallery/presentation/widget/album_tile.dart';
import 'package:myco_flutter/features/gallery/presentation/widget/gallery_shimmer.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

/// GalleryScreen displays a grid of albums.
/// Each album shows an image grid, the album title, and the date.
/// The appearance is responsive to device size.
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // Controller for the album selection dropdown
  final albumController = TextEditingController();

  // load gallery albums
  Future<void> _loadGalleryAlbums() async {
    dev.log('Loading gallery albums...');

    final preferenceManager = GetIt.I<PreferenceManager>();
    final userId = await preferenceManager.getUserId();
    final languageId = await preferenceManager.getLanguageId();

    if (mounted) {
      context.read<GalleryBloc>().add(
        GetGalleryAlbum(
          societyId: '1',
          userId: userId ?? '',
          languageId: languageId ?? '',
          floorId: '151',
          blockId: '30',
        ),
      );
    }
  }

  @override
  void initState() {
    _loadGalleryAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(
      title: 'gallery',
      isKey: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.0 * Responsive.getResponsive(context),
      ),
      // albums
      child: Column(
        children: [
          // drop down
          NewTextField(
            hintText: 'All Photo',
            controller: albumController,
            onTap: () async {
              final albumList = [
                {'id': '1', 'name': '2025'},
                {'id': '2', 'name': '2024'},
                {'id': '3', 'name': '2023'},
                {'id': '4', 'name': '2022'},
                {'id': '5', 'name': '2021'},
                {'id': '0', 'name': 'Clear Sort'},
              ];

              final selectedAlbumId = await showCustomSimpleBottomSheet(
                context: context,
                dataList: albumList,
                heading: 'Select Album',
                searchHint: 'Search Albums',
                btnTitle: 'Select',
              );

              if (selectedAlbumId != null) {
                final selectedAlbum = selectedAlbumId as Map<String, dynamic>;
                final selectedYear = selectedAlbum['name'] as String;

                if (selectedAlbum['id'] == '0') {
                  //  Clear sort
                  albumController.clear();
                  context.read<GalleryBloc>().add(ClearFilter());
                  return;
                }

                dev.log(selectedYear, name: 'selectedYear');

                albumController.text = selectedYear;

                if (mounted) {
                  context.read<GalleryBloc>().add(FilterAlbums(selectedYear));
                }
              }
            },
          ),

          SizedBox(
            height: 0.02 * Responsive.getHeight(context),
          ), // spacing after dropdown
          // albums grid
          BlocBuilder<GalleryBloc, GalleryState>(
            builder: (context, state) {
              // Loading state
              if (state is GalleryInitial || state is GalleryLoading) {
                return const Expanded(child: GalleryShimmer());
              }

              // Error state
              if (state is GalleryError) {
                dev.log('Error loading gallery albums: ${state.message}');
                return Expanded(
                  child: Center(
                    child: CustomText(
                      state.message,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.getColor(context).error,
                    ),
                  ),
                );
              }

              // loaded state
              if (state is GalleryLoaded) {
                final albums = state.filteredAlbums;

                dev.log(
                  'Gallery albums loaded: ${albums.length}',
                  name: 'GalleryScreen',
                );

                if (albums.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.noGalleryFound,
                          height: 0.1 * Responsive.getHeight(context),
                          width: 0.02 * Responsive.getWidth(context),
                        ),

                        // no data available
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8.0 * Responsive.getResponsive(context),
                          ),
                          child: CustomText(
                            'data_not_available',
                            fontWeight: FontWeight.w600,
                            fontSize:
                                18 * Responsive.getResponsiveText(context),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          150.0 * Responsive.getResponsive(context),
                      crossAxisSpacing:
                          12.0 * Responsive.getResponsive(context),

                      childAspectRatio: Responsive.isTablet(context)
                          ? Responsive.getResponsive(context) * 4 / 8.1
                          : Responsive.getResponsive(context) * 4 / 5.5,
                    ),
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      final album = albums[index];

                      // album images
                      final imageUrls =
                          album.images
                              ?.map((e) => e.galleryPhoto)
                              .whereType<String>()
                              .toList() ??
                          [];
                      // Layout for each album: 2x2 image grid (AlbumTile) + title + date
                      return GestureDetector(
                        onTap: () async {
                          context.push(
                            RoutePaths.albumView,
                            extra: {
                              'albumName': album.albumTitle ?? '',
                              'galleryAlbumId': album.galleryAlbumId ?? '',
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // AlbumTile displays a 2x2 grid of album images
                            AlbumTile(imageUrls: imageUrls),

                            // album title
                            Padding(
                              padding: EdgeInsets.only(
                                top: 4.0 * Responsive.getResponsive(context),
                              ),
                              child: CustomText(
                                album.albumTitle ?? '',
                                fontSize:
                                    14 * Responsive.getResponsive(context),
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // album date
                            CustomText(
                              album.eventDate?.toString().split(' ')[0] ?? '',
                              fontSize: 12 * Responsive.getResponsive(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    albumController.dispose();
    super.dispose();
  }
}
