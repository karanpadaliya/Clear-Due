import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class BottomGetStarted extends StatelessWidget {
  const BottomGetStarted({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(
        height: .52 * Responsive.getHeight(context),
        width: Responsive.getWidth(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 45.0 * Responsive.getResponsive(context),
            horizontal: 30 * Responsive.getResponsive(context),
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/sign_in/myco_logo.png',
                height: .095 * Responsive.getHeight(context),
                width: .5 * Responsive.getWidth(context),
              ),
              SizedBox(height: .02 * Responsive.getHeight(context)),
              CustomText(
                'Let’s Get Started',
                fontSize: 30 * Responsive.getResponsiveText(context),
                color: AppTheme
                    .getColor(context)
                    .onSurface,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: .02 * Responsive.getHeight(context)),
              CustomText(
                'To enhance your user experience, please set up your profile first. This will help us tailor the app to your needs and ensure you get the most out of our features!',
                fontSize: 16 * Responsive.getResponsiveText(context),
                color: AppTheme
                    .getColor(context)
                    .onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: .035 * Responsive.getHeight(context)),
              MyCoButton(
                onTap: () {
                  context.pop();
                  context.pop();
                  context.push("/contact-admin");
                },
                title: 'Set Up My Profile',
                boarderRadius: 30 * Responsive.getResponsive(context),
                isShadowBottomLeft: true,
              ),
              SizedBox(height: .02 * Responsive.getHeight(context)),
              MyCoButton(
                onTap: () {
                  context.go("/dashboard");
                },
                boarderRadius: 30 * Responsive.getResponsive(context),
                title: 'Explore The App First',
                backgroundColor: AppTheme
                    .getColor(context)
                    .onPrimary,
                textStyle: MyCoButtonTheme.getWhiteBackgroundTextStyle(context),
              ),
            ],
          ),
        ),
      );
}
