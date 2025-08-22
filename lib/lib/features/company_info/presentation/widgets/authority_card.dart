import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/company_info/domain/entities/company_info_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorityCard extends StatelessWidget {
  final CommitieEntity authority;
  final BuildContext context;

  const AuthorityCard({
    required this.authority,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).onInverseSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  (authority.adminProfile != null &&
                      authority.adminProfile!.isNotEmpty)
                  ? NetworkImage(authority.adminProfile!)
                  : const AssetImage('assets/default_avatar.png')
                        as ImageProvider,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authority.adminName ?? '',
                    style: TextStyle(
                      color: AppTheme.getColor(context).onSurface,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: 19 * Responsive.getResponsiveText(context),
                    ),
                  ),
                  Text(
                    authority.roleName ?? '',
                    style: TextStyle(
                      fontFamily: 'Gilroy-Medium',
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final phone = authority.adminMobile ?? '';
                      final uri = Uri(scheme: 'tel', path: phone);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    child: Text(
                      authority.adminMobile ?? '',
                      style: TextStyle(
                        fontFamily: 'Gilroy-Medium',
                        color: AppTheme.getColor(context).onSurface,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final email = authority.adminEmail?.trim() ?? '';
                      if (email.isEmpty || !email.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid or missing email address'),
                          ),
                        );
                        return;
                      }
                      await EasyLauncher.email(email: email);
                    },
                    child: Text(
                      authority.adminEmail ?? '',
                      style: TextStyle(
                        color: AppTheme.getColor(context).onSurface,
                        fontFamily: 'Gilroy-SemiBold',
                        fontWeight: FontWeight.w500,
                        fontSize: 14 * Responsive.getResponsiveText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Add your "Add Contact" logic here
              },
              child: SvgPicture.asset(
                'assets/visit_svgs/add_contact.svg',
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
}
