import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/gallery/presentation/bloc/album/album_bloc.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:share_plus/share_plus.dart';

class GalleryDownload extends StatelessWidget {
  const GalleryDownload({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AlbumBloc, AlbumState>(
    builder: (context, state) {
      if (state is AlbumError) {
        return FractionallySizedBox(
          heightFactor: 0.2,
          child: Center(child: CustomText(state.message)),
        );
      }

      if (state is AlbumDownloadState) {
        double heightMultiplier;
        final isTablet = Responsive.isTablet(context);

        if (isTablet) {
          heightMultiplier = state.isComplete ? 0.3 : 0.2;
        } else {
          heightMultiplier = state.isComplete ? 0.53 : 0.35;
        }

        return FractionallySizedBox(
          heightFactor: heightMultiplier * Responsive.getResponsive(context),
          child: CommonCard(
            title: state.fileName ?? 'Download',
            headerColor: AppTheme.getColor(context).primary,
            bottomWidget: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // shrink during download

                children: [
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: state.progress / 100,
                      minHeight: 8 * Responsive.getResponsive(context),
                      backgroundColor: Colors.grey.shade300,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Progress Text (show file name)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.isComplete ? 'Completed' : 'Downloading',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${state.progress.toStringAsFixed(0)}%',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  if (state.isComplete) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildCloseButton(context)),
                        if (state.isShare) ...[
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildShareButton(context, state.filePath),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }

      return const FractionallySizedBox(
        heightFactor: 0.2,
        child: Center(child: Text('Preparing download...')),
      );
    },
  );

  // Extracted method for the Close button
  Widget _buildCloseButton(BuildContext context) => MyCoButton(
    title: 'Close',
    onTap: () => Navigator.pop(context),
    backgroundColor: Colors.white,
    boarderRadius: 30 * Responsive.getResponsive(context),
    border: Border.all(color: AppTheme.getColor(context).primary),
    textStyle: TextStyle(color: AppTheme.getColor(context).primary),
  );

  // Extracted method for the Share button
  Widget _buildShareButton(BuildContext context, String? filePath) =>
      MyCoButton(
        title: 'Share',
        isShadowBottomLeft: true,
        boarderRadius: 30 * Responsive.getResponsive(context),
        onTap: () {
          if (filePath != null && filePath.isNotEmpty) {
            // Get the RenderBox of the button from its context.
            final box = context.findRenderObject() as RenderBox?;

            // Create a Rect from the button's position and size.
            final sharePositionOrigin = box != null
                ? box.localToGlobal(Offset.zero) & box.size
                : null;

            // Pass the Rect to the sharePositionOrigin parameter.
            SharePlus.instance.share(
              ShareParams(
                files: [XFile(filePath)],
                sharePositionOrigin: sharePositionOrigin,
              ),
            );
          }
        },
      );
}
