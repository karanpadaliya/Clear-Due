import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/custom_image_preview_page.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ImageGridPreviewWidget extends StatelessWidget {
  final List<String> imageList;
  final int containersLength;
  final double? boxHeight;
  final double? boxWidth;
  final bool showIndicators;
  final double borderRadius;
  final Color? selectIndicatorColor;
  final Color? unselectIndicatorColor;

  const ImageGridPreviewWidget({
    required this.imageList,
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.showIndicators = true,
    this.containersLength = 3,
    this.borderRadius = 16.0,
    this.selectIndicatorColor,
    this.unselectIndicatorColor,
  });

  @override
  Widget build(BuildContext context) =>
      _buildStyledImageRow(context, imageList);

  Widget _buildStyledImageRow(BuildContext context, List<String> images) {
    final int totalImages = images.length;
    final int maxVisibleContainers = containersLength.clamp(1, totalImages);
    final List<Widget> imageBoxes = [];

    for (int i = 0; i < maxVisibleContainers; i++) {
      if (i != 0 && i != maxVisibleContainers) {
        imageBoxes.add(const SizedBox(width: 10));
      }

      final bool isLastContainer = i == maxVisibleContainers - 1;
      final bool shouldShowExtra =
          totalImages > containersLength && isLastContainer;
      final int displayIndex = shouldShowExtra ? containersLength - 1 : i;

      imageBoxes.add(
        _imageBox(
          context,
          images,
          displayIndex,
          isExtraBox: shouldShowExtra,
          extraCount: totalImages - (containersLength - 1),
        ),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, children: imageBoxes);
  }

  Widget _imageBox(
    BuildContext context,
    List<String> images,
    int index, {
    bool isExtraBox = false,
    int extraCount = 0,
  }) {
    final height = boxHeight ?? MediaQuery.of(context).size.width * 0.20;
    final width = boxWidth ?? MediaQuery.of(context).size.width * 0.20;
    final String imageUrl = images[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImagePreview(
              images: images,
              startIndex: index,
              showIndicators: showIndicators,
              selectColor: selectIndicatorColor,
              unselectColor: unselectIndicatorColor,
            ),
          ),
        );
      },
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageUrl.startsWith('http')
                  ? CachedImage(imageUrl: imageUrl)
                  : Image.asset(imageUrl, fit: BoxFit.cover),
              if (isExtraBox)
                Container(
                  width: width,
                  height: height,
                  color: AppTheme.getColor(context).outlineVariant,
                  child: Center(
                    child: CustomText(
                      '+$extraCount',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
