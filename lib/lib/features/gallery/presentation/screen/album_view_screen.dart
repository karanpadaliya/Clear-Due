import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/network/network_info.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/album/album_bloc.dart';
import 'package:myco_flutter/features/gallery/presentation/widget/album_shimmer.dart';
import 'package:myco_flutter/features/gallery/presentation/widget/gallery_download.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AlbumViewScreen extends StatefulWidget {
  final String albumName;
  final String? galleryAlbumId;
  const AlbumViewScreen({
    required this.albumName,
    required this.galleryAlbumId,
    super.key,
  });

  @override
  State<AlbumViewScreen> createState() => _AlbumViewScreenState();
}

class _AlbumViewScreenState extends State<AlbumViewScreen> {
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  void _loadAlbumImages() async {
    // Logic to load album images goes here
    // This could involve fetching from a remote server or local database
    dev.log('Loading images for album: ${widget.albumName}');

    final preferenceManager = GetIt.I<PreferenceManager>();
    final userId = await preferenceManager.getUserId();
    final languageId = await preferenceManager.getLanguageId();

    if (mounted) {
      // ignore: use_build_context_synchronously
      context.read<AlbumBloc>().add(
        GetGalleryNew(
          societyId: '1',
          userId: userId ?? '',
          languageId: languageId ?? '',
          floorId: '151',
          blockId: '30',
          galleryAlbumId: widget.galleryAlbumId ?? '',
        ),
      );
    }
  }

  void _showDownloadBottomSheet({
    required BuildContext context,
    required String fileUrl,
    required int currentIndex,
    bool isShare = false, // Default to false for the download button
  }) {
    // Check if the widget is still in the tree
    if (!mounted) return;

    dev.log(fileUrl, name: 'gallery-file');
    dev.log(currentIndex.toString(), name: 'gallery-index');

    // Add the event to the BLoC, passing the isShare flag
    context.read<AlbumBloc>().add(
      DownloadAlbum(fileUrl: fileUrl, isShare: isShare),
    );

    // Show the bottom sheet (this code is now in one place)
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12 * Responsive.getResponsive(context),
          vertical: 20 * Responsive.getResponsive(context),
        ),
        child: const Material(
          elevation: 12,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
            bottom: Radius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: GalleryDownload(),
        ),
      ),
    );
  }

  @override
  void initState() {
    _loadAlbumImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      isKey: false,
      title: widget.albumName,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    body: BlocBuilder<AlbumBloc, AlbumState>(
      // ignore: prefer_expression_function_bodies
      buildWhen: (previous, current) {
        // Only rebuild on this states:
        return current is AlbumLoaded ||
            current is AlbumInitial ||
            current is AlbumError ||
            current is AlbumLoading;
      },

      builder: (context, state) {
        if (state is AlbumInitial || state is AlbumLoading) {
          return const SizedBox.expand(child: AlbumShimmer());
        }

        if (state is AlbumError) {
          return Center(
            child: CustomText(state.message, fontWeight: FontWeight.w600),
          );
        }

        if (state is AlbumLoaded) {
          // Extract images from the loaded entity
          final images = state.getGalleryNewEntity.images;

          // If images are null or empty, show a message
          if (images == null || images.isEmpty) {
            return const Center(
              child: CustomText('no_image_found', fontWeight: FontWeight.w600),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent:
                  150.0 *
                  Responsive.getResponsive(
                    context,
                  ), // Adjusted for better responsiveness
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];
              return GestureDetector(
                onTap: () async {
                  final List<String?> galleryPhotos = images
                      .map((e) => e.galleryPhoto)
                      .toList();

                  if (await networkInfo.isConnected == false) {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                      msg:
                          'You’re offline — please connect to the internet to view this album.',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                    return;
                  }

                  if (!context.mounted) return;

                  context.push(
                    RoutePaths.albumViewer,
                    extra: {
                      'images': galleryPhotos.whereType<String>().toList(),
                      'startIndex': index,
                      'appbarTitle': '',
                      'showIndicators': false,
                      'suffixBuilder': (int currentIndex) {
                        final downloadGallery = images[currentIndex];
                        final fileUrl = downloadGallery.galleryPhoto ?? '';

                        return Row(
                          children: [
                            // Share Button
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    8.0 * Responsive.getResponsive(context),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // SHARE
                                  _showDownloadBottomSheet(
                                    context: context,
                                    fileUrl: fileUrl,
                                    currentIndex: currentIndex,
                                    isShare: true, // Pass true for sharing
                                  );
                                },
                                child: SvgPicture.asset(
                                  AppAssets.share,
                                  height: 0.03 * Responsive.getHeight(context),
                                ),
                              ),
                            ),

                            // Download Button
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    8.0 * Responsive.getResponsive(context),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // DOWNLOAD
                                  _showDownloadBottomSheet(
                                    context: context,
                                    fileUrl: fileUrl,
                                    currentIndex: currentIndex,
                                  );
                                },
                                child: SvgPicture.asset(
                                  AppAssets.galleryDownload,
                                  height: 0.03 * Responsive.getHeight(context),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    },
                  );
                },
                child: CustomCachedNetworkImage(
                  imageUrl: image.galleryPhoto ?? '',
                  errorWidget: Image.asset(AppAssets.myCoLogo),
                  borderRadius: BorderRadius.zero,
                ),
              );
            },
          );
        }
        return SizedBox.fromSize();
      },
    ),
  );
}
