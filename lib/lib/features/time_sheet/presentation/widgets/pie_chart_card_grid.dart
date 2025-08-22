import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class StatusCardData {
  final String count;
  final String title;
  final String icon;
  final Color color;

  StatusCardData({
    required this.count,
    required this.title,
    required this.icon,
    required this.color,
  });
}

class EnvelopePeekCardGrid extends StatelessWidget {
  final List<StatusCardData> cards;
  final bool areCardsOpen;

  const EnvelopePeekCardGrid({
    required this.cards,
    required this.areCardsOpen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal:
          VariableBag.screenHorizontalPadding *
          Responsive.getResponsive(context),
      vertical: 24 * Responsive.getResponsive(context),
    ),
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16 * Responsive.getResponsive(context),
      mainAxisSpacing: 16 * Responsive.getResponsive(context),
      childAspectRatio: 1.90,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cards
          .map(
            (data) => PeekableStatusCard(
              count: data.count,
              title: LanguageManager().get(data.title),
              icon: data.icon,
              color: data.color,
              isOpen: areCardsOpen,
            ),
          )
          .toList(),
    ),
  );
}

class PeekableStatusCard extends StatefulWidget {
  final String title;
  final String count;
  final Color color;
  final String icon;
  final bool isOpen;

  const PeekableStatusCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
    required this.isOpen,
    super.key,
  });

  @override
  State<PeekableStatusCard> createState() => _PeekableStatusCardState();
}

class _PeekableStatusCardState extends State<PeekableStatusCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;

  final double cardHeight = 120;
  final double peekHeight = 36;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<double>(
      begin: cardHeight - peekHeight,
      end: 0,
    ).animate(curvedAnimation);

    _borderRadiusAnimation = BorderRadiusTween(
      begin: const BorderRadius.vertical(top: Radius.circular(12)),
      end: BorderRadius.circular(12.0),
    ).animate(curvedAnimation);

    if (widget.isOpen) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(PeekableStatusCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      _toggleCard(open: widget.isOpen);
    }
  }

  void _toggleCard({required bool open}) {
    if (open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.getResponsive(context);
    final textScale = Responsive.getResponsiveText(context);

    return GestureDetector(
      onTap: () {
        // Tap is handled by the pie chart now, but can add other interactions here.
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => ClipRRect(
          borderRadius: _borderRadiusAnimation.value! * responsive,
          child: SizedBox(
            width: double.infinity,
            height: cardHeight * responsive,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value * responsive),
              child: Container(
                decoration: BoxDecoration(
                  // And also use it here for the decoration
                  borderRadius: _borderRadiusAnimation.value! * responsive,
                  boxShadow: [
                    BoxShadow(color: widget.color.withAlpha(180)),
                    BoxShadow(
                      color: widget.color,
                      offset: const Offset(0, 6),
                      spreadRadius: -4.0,
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * responsive,
                  vertical: 10 * responsive,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10 * responsive),
                      child: SvgPicture.asset(
                        widget.icon,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                        height: 28 * responsive,
                        width: 28 * responsive,
                      ),
                    ),
                    SizedBox(width: 12 * responsive),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            widget.count,
                            fontWeight: FontWeight.w700,
                            fontSize: 16 * textScale,
                            color: AppColors.white,
                          ),
                          CustomText(
                            widget.title,
                            fontWeight: FontWeight.w600,
                            fontSize: 14 * textScale,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
