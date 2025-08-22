import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class PersonData {
  final String firstName;
  final String lastName;
  final String imagePath;
  final bool isActive;

  PersonData({
    required this.firstName,
    required this.lastName,
    required this.imagePath,
    this.isActive = false,
  });
}

class OverlappingPeopleCard extends StatelessWidget {
  final List<PersonData> people;
  final double imageSize;
  final double statusDotSize;
  final double overlapFactor;

  const OverlappingPeopleCard({
    required this.people,
    super.key,
    this.imageSize = 75.0,
    this.statusDotSize = 16.0,
    this.overlapFactor =
        58.0, // This controls the horizontal position of each next person
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total width required by the stack to perfectly fit its children
    final double calculatedWidth = people.isEmpty
        ? 0
        : (people.length - 1) * overlapFactor + imageSize;

    return SizedBox(
      // Total height for the image, status dot, and text below it
      height: imageSize + 50,
      width: calculatedWidth,
      child: Stack(
        children: List.generate(people.length, (index) {
          final person = people[index];
          final Color statusColor = person.isActive
              ? const Color(0xFF1CE742)
              : Colors.red;

          return Positioned(
            left: index * overlapFactor, // Position each person with an overlap
            child: SizedBox(
              width: imageSize,
              child: Column(
                children: [
                  // Stack for Profile Image and Status Dot
                  SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Profile Image with White Border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.getColor(context).surface,
                              width: 3,
                            ),
                          ),
                          child: CustomCachedNetworkImage(
                            imageUrl: person.imagePath,
                            isCircular: true,
                            height: imageSize,
                            userName: '${person.firstName} ${person.lastName}',
                          ),
                        ),
                        // Status Dot with White Border
                        Positioned(
                          bottom: -4, // Slight overlap on the bottom border
                          child: Container(
                            width: statusDotSize,
                            height: statusDotSize,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // First Name
                  CustomText(
                    person.firstName,
                    fontSize: 11 * Responsive.getDashboardResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Last Name
                  CustomText(
                    person.lastName,
                    fontSize: 11 * Responsive.getDashboardResponsiveText(context),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
