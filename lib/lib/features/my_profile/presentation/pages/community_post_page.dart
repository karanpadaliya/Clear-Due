import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class CommunityPostPage extends StatefulWidget {
  const CommunityPostPage({super.key});

  @override
  State<CommunityPostPage> createState() => _CommunityPostPageState();
}

class _CommunityPostPageState extends State<CommunityPostPage> {
  final List<String> postContents = [
    'https://i.pinimg.com/564x/ce/9f/2a/ce9f2a2ce80fe49e83e9df49a7403993.jpg',
    'This is a text post describing a great experience.',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  bool isImage(String url) =>
      Uri.tryParse(url)?.hasAbsolutePath == true &&
      (url.endsWith('.jpg') ||
          url.endsWith('.jpeg') ||
          url.endsWith('.png') ||
          url.endsWith('.webp'));

  bool isVideo(String url) => Uri.tryParse(url)?.hasAbsolutePath == true && url.endsWith('.mp4');

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Post Header
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * Responsive.getResponsive(context),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30 * Responsive.getResponsive(context),
                backgroundImage: const NetworkImage(
                  'https://i.pinimg.com/564x/ce/9f/2a/ce9f2a2ce80fe49e83e9df49a7403993.jpg',
                ),
              ),
              SizedBox(width: 0.025 * Responsive.getWidth(context)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Mahesh Babu',
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * Responsive.getResponsiveText(context),
                    isKey: false,
                  ),
                  CustomText(
                    '2 days ago',
                    fontSize: 12 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).outline,
                    isKey: false,
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                AppAssets.more,
                height: 0.025 * Responsive.getHeight(context),
              ),
            ],
          ),
        ),

        SizedBox(height: 0.015 * Responsive.getHeight(context)),

        /// Auto-adaptive content (image/video/text)
        Stack(
          children: [
            ClipRRect(
              child: SizedBox(
                height: 0.400 * Responsive.getHeight(context),
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: postContents.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final content = postContents[index];

                    if (isImage(content)) {
                      return Image.network(content, fit: BoxFit.cover);
                    } else if (isVideo(content)) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: VideoPlayerWidget(url: content),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: CustomText(
                            content.toString(),
                            fontSize:
                                14 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w500,
                            isKey: false,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            /// Index Badge
            Positioned(
              top: 10 * Responsive.getResponsive(context),
              right: 10 * Responsive.getResponsive(context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.025 * Responsive.getWidth(context),
                  vertical: 0.004 * Responsive.getHeight(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomText(
                  '${_currentIndex + 1}/${postContents.length}',
                  color: AppTheme.getColor(context).onPrimary,
                  fontSize: 12 * Responsive.getResponsiveText(context),
                ),
              ),
            ),

            /// Dots Indicator
            Positioned(
              bottom: 10 * Responsive.getResponsive(context),
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  postContents.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: 0.009 * Responsive.getWidth(context),
                    ),
                    width: _currentIndex == index ? 10 : 6,
                    height: 0.008 * Responsive.getHeight(context),
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(
                        3 * Responsive.getResponsive(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.012 * Responsive.getHeight(context)),

        /// Post Actions
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * Responsive.getResponsive(context),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.heart),
              SizedBox(width: 0.030 * Responsive.getWidth(context)),
              SvgPicture.asset(AppAssets.message),
              SizedBox(width: 0.030 * Responsive.getWidth(context)),
              SvgPicture.asset(AppAssets.send2),
              const Spacer(),
              SvgPicture.asset(AppAssets.save2),
            ],
          ),
        ),

        SizedBox(height: 0.005 * Responsive.getHeight(context)),

        /// Likes Row
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * Responsive.getResponsive(context),
          ),
          child: Row(
            children: [
              CustomText(
                'Liked By',
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).outline,
                isKey: false,
              ),
              SizedBox(width: 0.020 * Responsive.getWidth(context)),
              SizedBox(
                width: 0.15 * Responsive.getWidth(context),
                height: 0.028 * Responsive.getHeight(context),
                child: Stack(
                  children: List.generate(
                    3,
                    (i) => Positioned(
                      left: (i * 17) * Responsive.getResponsive(context),
                      child: CircleAvatar(
                        radius: 13 * Responsive.getResponsive(context),
                        backgroundImage: const NetworkImage(
                          'https://i.pinimg.com/564x/ce/9f/2a/ce9f2a2ce80fe49e83e9df49a7403993.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CustomText(
                '15 Likes',
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).outline,
                isKey: false,
              ),
            ],
          ),
        ),

        /// Caption
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10 * Responsive.getResponsive(context),
          ),
          child: CustomText(
            'Great memories with the team! 🎉',
            fontWeight: FontWeight.w500,
            fontSize: 14 * Responsive.getResponsiveText(context),
            isKey: false,
          ),
        ),
        const Divider(),
      ],
    ),
  );
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  const VideoPlayerWidget({required this.url, super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showPlayIcon = true; // Track overlay icon

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.setLooping(false);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVideoTap() {
    if (!_controller.value.isPlaying) {
      _controller.play();
      setState(() => _showPlayIcon = false);
    } else {
      _controller.pause();
      setState(() => _showPlayIcon = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: GestureDetector(
        onTap: _onVideoTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            if (_showPlayIcon)
              Container(
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: VideoProgressIndicator(_controller, allowScrubbing: true),
            ),
          ],
        ),
      ),
    );
  }
}
