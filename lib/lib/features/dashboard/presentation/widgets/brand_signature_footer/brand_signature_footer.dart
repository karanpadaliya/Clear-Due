import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// You can place this widget at the bottom of your dashboard's Column or ListView.
class BrandSignatureFooter extends StatefulWidget {
  const BrandSignatureFooter({super.key});

  @override
  State<BrandSignatureFooter> createState() => _BrandSignatureFooterState();
}

class _BrandSignatureFooterState extends State<BrandSignatureFooter> {
  // This boolean will control the visibility of the "extra letters".
  bool _isDetailsVisible = false;

  // This will hold our time-based emoji.
  // 'late' means we promise to initialize it before it's used (we will in initState).
  late final String _timeBasedEmoji;

  @override
  void initState() {
    super.initState();
    // Set the emoji once when the widget is first created.
    _timeBasedEmoji = _getEmojiForTimeOfDay();
  }

  /// Determines which emoji to show based on the hour of the day.
  String _getEmojiForTimeOfDay() {
    final hour = DateTime.now().hour; // Gets the hour (0-23)

    if (hour >= 5 && hour < 12) {
      return '💪'; // Morning Coffee
    } else if (hour >= 12 && hour < 17) {
      return '❤️'; // Afternoon Power
    } else if (hour >= 17 && hour < 22) {
      return '🫶'; // Evening Sparkle
    } else {
      return '🫶'; // Night Owl
    }
  }

  /// Handles the tap event on the emoji.
  void _onEmojiTap() {
    // 1. Trigger haptic feedback for a satisfying physical response.
    HapticFeedback.lightImpact();

    // 2. Update the state to toggle the visibility of the extra details.
    setState(() {
      _isDetailsVisible = !_isDetailsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // "MyCo" - The main brand name
          CustomText(
            'app_name',
            fontSize: 32 * Responsive.getDashboardResponsiveText(context),
            fontWeight: FontWeight.w800,
            color: Color(0xff929292),
          ),
          // const SizedBox(height: 8),

          // "Your Daily Companion at Work." - The tagline
          CustomText(
            'your_daily',
            fontSize: 32 * Responsive.getDashboardResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: Color(0xffababab),
          ),
          CustomText(
            'companion_at_work',
            fontSize: 32 * Responsive.getDashboardResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: Color(0xffababab),
          ),
          // const SizedBox(height: 12),

          // The "Crafted with..." line, built with a Row for alignment.
          // We use RichText for better control over text spans and gestures.
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: CustomText(
                    'crafted_with',
                    fontSize:
                        16 * Responsive.getDashboardResponsiveText(context),
                    color: Color(0xff929292),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // const TextSpan(text: 'Crafted with '),
                // This is our interactive emoji.
                WidgetSpan(
                  child: GestureDetector(
                    onTap: _onEmojiTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomText(_timeBasedEmoji),
                    ),
                  ),
                ),
                // This is the animated "more letters" part.
                // It smoothly fades in and out.
                WidgetSpan(
                  child: AnimatedCrossFade(
                    firstChild: const SizedBox(
                      width: 0,
                      height: 0,
                    ), // Hidden state
                    secondChild: CustomText(
                      // Visible state
                      'ahmedabad_india',
                      fontSize:
                          16 * Responsive.getDashboardResponsiveText(context),
                      color: Color(0xff929292),
                      fontWeight: FontWeight.w500,
                    ),
                    crossFadeState: _isDetailsVisible
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
