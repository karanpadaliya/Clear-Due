import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

class ChatListCardSkeleton extends StatelessWidget {
  final bool? isSufixIcon;

  const ChatListCardSkeleton({super.key, this.isSufixIcon = false});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final double responsive = Responsive.getResponsive(context);
    final double textScale = Responsive.getResponsiveText(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).onPrimary,
        border: Border.all(color: AppTheme.getColor(context).outline),
        borderRadius: BorderRadius.circular(12 * responsive),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: 12.0 * responsive,
          right: 12.0 * responsive,
          top: 6.0 * responsive,
          bottom: 6.0 * responsive,
        ),
        leading: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 35 * responsive,
          ),
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 16 * textScale,
            width: 120,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.only(bottom: 4),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 14 * textScale,
                width: 160,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.only(bottom: 6),
              ),
            ),
            if (!(isSufixIcon ?? false))
              Align(
                alignment: Alignment.bottomRight,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 12 * textScale,
                    width: 40,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
          ],
        ),
        trailing: (isSufixIcon ?? false)
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
