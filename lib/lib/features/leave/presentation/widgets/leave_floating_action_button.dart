import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';

class LeaveFloatingActionButtonModel {
  final String label;
  final String? iconPath;
  final IconData? icon;
  final VoidCallback onTap;

  LeaveFloatingActionButtonModel({
    required this.label,
    required this.onTap,
    this.iconPath,
    this.icon,
  }) : assert(
         iconPath != null || icon != null,
         'Provide either iconPath or icon.',
       );
}

class LeaveFloatingActionButton extends StatefulWidget {
  final List<LeaveFloatingActionButtonModel> actions;
  final double imageSize;
  final IconData openIcon;
  final IconData closeIcon;
  final VoidCallback? onTap;
  final double? innerIconSize;
  final double? innerImageHeight;
  final double? innerImageWidth;
  final double? circleAvatarRadius;
  final Color? innerIconBgr;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const LeaveFloatingActionButton({
    required this.actions,
    required this.openIcon,
    required this.closeIcon,
    super.key,
    this.onTap,
    this.imageSize = 60,
    this.innerIconSize,
    this.innerImageHeight,
    this.innerImageWidth,
    this.innerIconBgr,
    this.circleAvatarRadius,
    this.margin,
    this.padding,
    this.decoration,
  });

  @override
  State<LeaveFloatingActionButton> createState() =>
      _LeaveFloatingActionButtonState();
}

class _LeaveFloatingActionButtonState extends State<LeaveFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _textAnimation;
  final String _closeText = 'CLOSE';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // ✅ Initialize _textAnimation AFTER _controller is ready
    _textAnimation = Tween<double>(begin: 0, end: _closeText.length.toDouble())
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomRight,
    children: [
      // if (_isExpanded)
      // GestureDetector(
      //   onTap: _toggle, // Tapping the background closes the FAB
      //   child: AnimatedOpacity(
      //     opacity: _isExpanded ? 0.6 : 0.0,
      //     duration: const Duration(milliseconds: 300),
      //
      //     child: Container(
      //       color: Colors.black,
      //       // width: MediaQuery.of(context).size.width ,
      //       // height: MediaQuery.of(context).size.height,
      //     ),
      //   ),
      // ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...widget.actions.asMap().entries.map((entry) {
            final index = entry.key;
            final action = entry.value;
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          0.0,
                          1.0 - index * 0.1,
                          curve: Curves.easeOut,
                        ),
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOption(
                    action,
                    widget.innerIconSize,
                    widget.innerImageHeight,
                    widget.innerImageWidth,
                    widget.circleAvatarRadius,
                    widget.innerIconBgr,
                    widget.margin,
                    widget.padding,
                    widget.decoration,
                  ),
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: widget.onTap ?? _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.imageSize,
              width: _isExpanded ? 130 : widget.imageSize,
              padding: _isExpanded
                  ? const EdgeInsets.symmetric(horizontal: 5)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primary,
                borderRadius: BorderRadius.circular(_isExpanded ? 30 : 100),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: _isExpanded
                      ? Row(
                          key: const ValueKey('close'),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.closeIcon,
                              size: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            AnimatedBuilder(
                              animation: _textAnimation,
                              builder: (context, child) {
                                final visibleCharCount = _textAnimation.value
                                    .ceil()
                                    .clamp(0, _closeText.length);
                                final visibleText = _closeText.substring(
                                  0,
                                  visibleCharCount,
                                );
                                return Text(
                                  visibleText,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : FittedBox(
                          key: const ValueKey('open'),
                          fit: BoxFit.cover,
                          child: Icon(
                            widget.openIcon,
                            color: Colors.white,
                            size: widget.imageSize * 0.9,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildOption(
    LeaveFloatingActionButtonModel action,
    double? innerIconSize,
    double? innerImageHeight,
    double? innerImageWidth,
    double? circleAvatarRadius,
    Color? innerIconBgr,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Decoration? decoration,
  ) => InkWell(
    onTap: action.onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: margin ?? const EdgeInsets.only(right: 10),
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration:
              decoration ??
              BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
          child: Text(
            action.label,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        CircleAvatar(
          backgroundColor: innerIconBgr ?? Colors.white,
          radius: circleAvatarRadius ?? 23,
          child: action.iconPath != null
              ? Image.asset(
                  action.iconPath!,
                  fit: BoxFit.cover,
                  width: innerImageWidth ?? 30,
                  height: innerImageHeight ?? 30,
                )
              : Icon(
                  action.icon,
                  size: innerIconSize ?? 25,
                  color: AppColors.primary,
                ),
        ),
      ],
    ),
  );
}
