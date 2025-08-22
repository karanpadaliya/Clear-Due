import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/custom_image_preview_page.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/album/album_bloc.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/gallery/gallery_bloc.dart';
import 'package:myco_flutter/features/gallery/presentation/screen/album_view_screen.dart';
import 'package:myco_flutter/features/gallery/presentation/screen/gallery_screen.dart';

List<RouteBase> galleryRoutes = [
  ShellRoute(
    builder: (context, state, child) => MultiBlocProvider(
      providers: [
        BlocProvider<GalleryBloc>(create: (context) => GetIt.I<GalleryBloc>()),
        BlocProvider<AlbumBloc>(create: (context) => GetIt.I<AlbumBloc>()),
      ],
      child: child,
    ),
    routes: [
      GoRoute(
        path: RoutePaths.gallery,
        name: 'GalleryVC',
        builder: (context, state) => const GalleryScreen(),
        // name: 'gallery',
      ),
      GoRoute(
        path: RoutePaths.albumView,
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, String>;
          return AlbumViewScreen(
            albumName: extra['albumName'] ?? '',
            galleryAlbumId: extra['galleryAlbumId'] ?? '',
          );
        },
        // name: 'album-view',
      ),
      GoRoute(
        path: RoutePaths.albumViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};

          return ImagePreview(
            images: extra['images'] as List<String>? ?? [],
            startIndex: extra['startIndex'] as int? ?? 0,
            appbarTitle: extra['appbarTitle'] as String? ?? '',
            showIndicators: extra['showIndicators'] as bool? ?? false,
            suffixBuilder:
                extra['suffixBuilder'] as Widget? Function(int currentIndex)?,
          );
        },
      ),
    ],
  ),
];
