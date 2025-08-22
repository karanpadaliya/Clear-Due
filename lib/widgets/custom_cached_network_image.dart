import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

/// A unified widget for displaying images from the network (with caching) or local assets.
///
/// This widget handles:
/// - Caching for network images.
/// - A shimmer loading placeholder.
/// - Sophisticated error handling:
///   1. Shows a custom [errorWidget] if provided.
///   2. Shows user initials as a fallback if a [userName] is given.
///   3. Shows a default broken image icon otherwise.
/// - Both circular (for avatars) and rounded rectangle clipping.
class CustomCachedNetworkImage extends StatelessWidget {
  /// The URL of the network image or the path to the local asset.
  final String imageUrl;

  /// The name of the user. If provided, the initials will be used as a
  /// fallback if a network image fails to load.
  final String? userName;

  /// The desired width of the image.
  final double? width;

  /// The desired height of the image.
  /// If [isCircular] is true, this is used as the diameter of the circle.
  final double? height;

  /// How the image should be inscribed into the box. Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// A custom widget to display if the image fails to load.
  /// This overrides the default initials/icon fallback logic.
  final Widget? errorWidget;

  /// The border radius for the image container and placeholders.
  /// This is ignored if [isCircular] is true.
  final BorderRadius borderRadius;

  /// If true, the image is clipped to a circle.
  /// When true, [height] must be provided and will be used for both width and height.
  final bool isCircular;

  const CustomCachedNetworkImage({
    required this.imageUrl, super.key,
    this.userName,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.isCircular = false,
  }) : assert(
  !isCircular || height != null,
  'Height must be provided for a circular image.',
  );

  /// Extracts initials from a full name (e.g., "John Doe" -> "JD").
  String _getInitials(String name) {
    final parts = name.trim().split(' ').where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length > 1) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first.substring(0, min(parts.first.length, 2)).toUpperCase();
  }

  /// Builds the fallback widget displayed on error.
  Widget _buildErrorWidget(BuildContext context, double? imageWidth) {
    if (errorWidget != null) {
      return errorWidget!;
    }
    if (userName != null && userName!.trim().isNotEmpty) {
      final initials = _getInitials(userName!);
      return Container(
        width: imageWidth,
        height: height,
        color: AppTheme.getColor(context).outline,
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              color: AppTheme.getColor(context).onPrimary,
              fontSize: (height ?? 60) / 2.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return Container(
      width: imageWidth,
      height: height,
      color: AppTheme.getColor(context).outline,
      child: Icon(
        Icons.broken_image_rounded,
        color: AppTheme.getColor(context).outlineVariant,
        size: ((imageWidth ?? height ?? 60)) / 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- 1. Common Layout & Styling Calculations ---
    final imageWidth = isCircular ? height : width;
    final imageBorderRadius =
    isCircular ? BorderRadius.circular(height! / 2) : borderRadius;

    // --- 2. Handle Empty Image Path ---
    if (imageUrl.trim().isEmpty) {
      return ClipRRect(
        borderRadius: imageBorderRadius,
        child: _buildErrorWidget(context, imageWidth),
      );
    }

    // --- 3. Determine Image Type and Build Accordingly ---
    final isNetworkImage = imageUrl.startsWith('http');

    // Build the widget with the correct clipping
    return ClipRRect(
      borderRadius: imageBorderRadius,
      child: isNetworkImage
      // --- A. Network Image Logic ---
          ? CachedNetworkImage(
        imageUrl: imageUrl,
        width: imageWidth,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: imageWidth,
            height: height,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) =>
            _buildErrorWidget(context, imageWidth),
      )
      // --- B. Asset Image Logic ---
          : Image.asset(
        imageUrl,
        width: imageWidth,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
        // Use the same error logic for missing assets
        _buildErrorWidget(context, imageWidth),
      ),
    );
  }
}