import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/design_border_container.dart';

class LeaveImageGridBottomSheet extends StatelessWidget {
  final List<String> imageUrls;
  final String buttonText;

  const LeaveImageGridBottomSheet({
    required this.imageUrls,
    super.key,
    this.buttonText = 'Show Leave Images',
  });

  void _showImages(BuildContext context) {
    final height = Responsive.getHeight(context);
    final width = Responsive.getWidth(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        height: height * 0.5,
        // Increased height for better spacing on tall screens
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: imageUrls.length,
                padding: EdgeInsets.all(0.01 * height),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > 600 ? 4 : 3,
                  // More columns on wide screens
                  crossAxisSpacing: width * 0.02,
                  mainAxisSpacing: height * 0.015,
                ),
                itemBuilder: (context, index) => DesignBorderContainer(
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.2),
                  borderRadius: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.015,
              ),
              child: MyCoButton(
                onTap: () => Navigator.pop(context),
                title: 'CLOSE',
                isShadowBottomLeft: true,
                boarderRadius: 50,
                height: height * 0.06,
                fontWeight: FontWeight.w600,
                // You can customize width or keep default
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => _showImages(context),
    child: Text(
      buttonText,
      style: TextStyle(fontSize: 16 * Responsive.getResponsiveText(context)),
    ),
  );
}
