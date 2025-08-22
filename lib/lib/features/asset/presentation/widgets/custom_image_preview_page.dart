import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';

class ImagePreview extends StatefulWidget {
  final List<String> images;
  final int startIndex;
  final bool showIndicators;
  final Color? selectColor;
  final Color? unselectColor;
  final String? appbarTitle;

  final Widget? Function(int currentIndex)? suffixBuilder;

  const ImagePreview({
    required this.images,
    required this.startIndex,
    super.key,
    this.showIndicators = true,
    this.selectColor,
    this.unselectColor,
    this.appbarTitle,
    this.suffixBuilder,
  });

  @override
  State<ImagePreview> createState() => ImagePreviewState();
}

class ImagePreviewState extends State<ImagePreview> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.appbarTitle ?? 'assets',
        titleSpacing: 0,
        actions: [
          // FIX: Changed widget.suffixBuilder! to widget.suffixBuilder?.call()
          widget.suffixBuilder?.call(_currentIndex) ?? const SizedBox.shrink(),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) => Center(
                child: InteractiveViewer(
                  child: _buildImage(
                    widget.images[index],
                    screenSize.width,
                    screenSize.height,
                  ),
                ),
              ),
            ),
            if (widget.showIndicators)
              Positioned(
                bottom: 0.03 * Responsive.getHeight(context),
                left: 0,
                right: 0,
                child: Visibility(
                  visible: widget.images.length <= 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicators(
                      widget.images.length,
                      _currentIndex,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicators(int total, int current) =>
      List.generate(total, (index) {
        final bool isActive = index == current;
        return _dot(isActive);
      });

  Widget _dot(bool isActive) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 12 : 8,
    height: isActive ? 12 : 8,
    decoration: BoxDecoration(
      color: isActive
          ? widget.selectColor ?? Colors.black
          : widget.unselectColor ?? Colors.grey,
      shape: BoxShape.circle,
    ),
  );

  Widget _buildImage(String path, double width, double height) =>
      InteractiveViewer(
        maxScale: 5.0,
        child: CustomCachedNetworkImage(
          imageUrl: path,
          fit: BoxFit.contain,
          width: width,
          height: height,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
