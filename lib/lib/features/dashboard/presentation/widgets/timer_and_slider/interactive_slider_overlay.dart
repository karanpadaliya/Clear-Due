import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/custom_image_preview_page.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/custom_slider.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractiveSliderOverlay extends StatefulWidget {
  final List<SliderEntity> sliders;
  final double height;

  const InteractiveSliderOverlay({
    required this.sliders,
    required this.height,
    super.key,
  });

  @override
  State<InteractiveSliderOverlay> createState() =>
      _InteractiveSliderOverlayState();
}

class _InteractiveSliderOverlayState extends State<InteractiveSliderOverlay>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _controller;
  OverlayEntry? _overlayEntry;
  final GlobalKey _sliderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _open(int index) {
    if (_overlayEntry != null) return;

    setState(() {
      _selectedIndex = index;
    });

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  Future<void> _close() async {
    await _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  SliderEntity get _current => widget.sliders[_selectedIndex];

  OverlayEntry _createOverlayEntry() {
    final renderBox =
        _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    // Fallback if renderBox is not available
    if (renderBox == null) {
      return OverlayEntry(builder: (context) => const SizedBox.shrink());
    }

    final screenSize = MediaQuery.of(context).size;
    final sliderSize = renderBox.size;
    final sliderPosition = renderBox.localToGlobal(Offset.zero);

    // Determine if the popup should open below the slider
    final openBelow =
        (sliderPosition.dy + sliderSize.height / 2) < screenSize.height / 2;

    final slideAnimation = Tween<Offset>(
      begin: openBelow ? const Offset(0, -0.1) : const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    return OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          onTap: _close,
          child: Container(
            color: Colors.black54,
            child: Stack(
              children: [
                Positioned(
                  left: 12,
                  right: 12,
                  top: openBelow
                      ? sliderPosition.dy + sliderSize.height + 8
                      : null,
                  bottom: openBelow
                      ? null
                      : screenSize.height - sliderPosition.dy + 8,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: _PopupCard(
                      entity: _current,
                      onClose: _close,
                      onOpenPreview: () => _openImagePreview(context),
                      onOpenLink: () => _openUrl(_current.pageUrl),
                      onWatch: () => _openYouTubeVideo(_current.youtubeUrl),
                      onShare: () => _share(context),
                      onCall: () => _makePhoneCall(_current.pageMobile),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openYouTubeVideo(String? videoId) async {
    if (videoId == null || videoId.isEmpty) return;

    final Uri youtubeUrl = Uri.parse(
      'https://www.youtube.com/watch?v=$videoId',
    );
    await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
  }

  Future<void> _share(BuildContext buttonContext) async {
    final url = _current.sliderImageName ?? '';
    if (url.isEmpty) return;

    final box = buttonContext.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Create the ShareParams object with text and origin
    final shareParams = ShareParams(
      text: url,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );

    // Call the share method with the params object
    await SharePlus.instance.share(shareParams);
  }

  Future<void> _makePhoneCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) return;

    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(phoneUri);
  }

  Future<void> _download(BuildContext context) async {
    final imagePath = _current.sliderImageName ?? '';
    try {
      late final Uint8List bytes;
      if (imagePath.startsWith('http')) {
        final response = await Dio().get<List<int>>(
          imagePath,
          options: Options(responseType: ResponseType.bytes),
        );
        bytes = Uint8List.fromList(response.data ?? <int>[]);
      } else {
        final data = await rootBundle.load(imagePath);
        bytes = data.buffer.asUint8List();
      }

      if (!mounted) return;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Downloaded ${bytes.lengthInBytes} bytes (preview only)',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  Future<void> _openImagePreview(BuildContext context) async {
    // Close the overlay and wait for its animation to finish
    await _close();

    // Then, push the new screen
    final images = widget.sliders.map((s) => s.sliderImageName ?? '').toList();
    if (!context.mounted) return; // Guard against async gaps
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePreview(
          images: images,
          startIndex: _selectedIndex,
          appbarTitle: 'Slider Preview',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.sliders.map((s) => s.sliderImageName ?? '').toList();
    // The overlay is now managed by the OverlayEntry, so the Stack is no longer needed here.
    return CustomSlider(
      key: _sliderKey, // Assign the key to find the slider's position
      imagePaths: images,
      isCarousel: true,
      height: widget.height,
      onImageTap: (index, _) => _open(index),
    );
  }
}

// No changes are needed for _PopupCard or _ActionChip, they remain the same.
class _PopupCard extends StatelessWidget {
  final SliderEntity entity;
  final VoidCallback onClose;
  final VoidCallback onOpenPreview;
  final VoidCallback onOpenLink;
  final VoidCallback onWatch;
  final VoidCallback onShare;
  final VoidCallback onCall;

  const _PopupCard({
    required this.entity,
    required this.onClose,
    required this.onOpenPreview,
    required this.onOpenLink,
    required this.onWatch,
    required this.onShare,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = entity.sliderImageName ?? '';
    final bool hasLink = (entity.pageUrl ?? '').isNotEmpty;
    final bool hasVideo = (entity.youtubeUrl ?? '').isNotEmpty;
    final bool hasPhoneNo = (entity.pageMobile ?? '').isNotEmpty;
    return Material(
      color: AppColors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.getColor(context).onSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: Icon(
                    Icons.close,
                    color: AppTheme.getColor(context).onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 2.4,
                child: GestureDetector(
                  onTap: onOpenPreview,
                  child: imageUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade800,
                            highlightColor: Colors.grey.shade700,
                            child: Container(color: Colors.black12),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.broken_image,
                            color: Colors.white70,
                          ),
                        )
                      : Image.asset(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.spaceEvenly,
              runSpacing: 8,
              spacing: 8,
              children: [
                if (hasPhoneNo)
                  _ActionChip(
                    icon: Icons.call_outlined,
                    label: 'call',
                    onPressed: onCall,
                  ),
                if (hasLink)
                  _ActionChip(
                    icon: Icons.link,
                    label: 'Open',
                    onPressed: onOpenLink,
                  ),
                if (hasVideo)
                  _ActionChip(
                    icon: Icons.ondemand_video,
                    label: 'Watch',
                    onPressed: onWatch,
                  ),
                _ActionChip(
                  icon: Icons.ios_share,
                  label: 'Share',
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => MyCoButton(
    onTap: onPressed,
    title: label,
    image: Icon(
      icon,
      size: 18,
      color: AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkprimary
          : AppColors.primary,
    ),
    // isTimecardbutton: true,
    spacing: 8,
    // isShadowBottomRight: true,
    // isShadowTopRight: true,
    isShadowBottomLeft: true,
    // isShadowTopLeft: true,
    width: 120 * Responsive.getDashboardResponsive(context),
    boarderRadius: 18,
    fontWeight: FontWeight.w600,
    textStyle: TextStyle(
      fontFamily: 'Gilroy-SemiBold',
      fontWeight: FontWeight.w600,
      color: AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkprimary
          : AppColors.primary,
    ),
    backgroundColor: AppColors.transparent,
    border: Border.all(color: AppTheme.getColor(context).primary, width: 1.5),
  );
  // @override
  // Widget build(BuildContext context) => ElevatedButton.icon(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: AppTheme.isAppThemeDarkMode(context)
  //         ? AppColors.darkprimary
  //         : AppColors.primary,
  //     foregroundColor: AppTheme.getColor(context).onPrimary,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  //   ),
  //   onPressed: onPressed,
  //   icon: Icon(icon, size: 18),
  //   label: Text(label),
  // );
}
