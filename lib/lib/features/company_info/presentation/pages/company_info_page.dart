import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/company_info/domain/use_cases/get_company_info.dart';
import 'package:myco_flutter/features/company_info/presentation/bloc/company_info_bloc.dart';
import 'package:myco_flutter/features/company_info/presentation/bloc/company_info_event.dart';
import 'package:myco_flutter/features/company_info/presentation/bloc/company_info_state.dart';
import 'package:myco_flutter/features/company_info/presentation/widgets/authority_card.dart';
import 'package:share_plus/share_plus.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        CompanyInfoBloc(getCompanyInfo: GetIt.I<GetCompanyInfo>())
          ..add(FetchCompanyInfo()),
    child: Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Company Info'),
      ),
      body: BlocBuilder<CompanyInfoBloc, CompanyInfoState>(
        builder: (context, state) {
          if (state is CompanyInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyInfoError) {
            return Center(child: Text(state.message));
          } else if (state is CompanyInfoLoaded) {
            final company = state.companyInfo;
            final committee = company.commitie ?? [];
            final logoUrl = state.companyInfo.companyLogo;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      logoUrl != null && logoUrl.isNotEmpty
                          ? Image.network(
                              logoUrl,
                              height: 0.24 * Responsive.getHeight(context),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/sign_in/myco_logo.png',
                                    height:
                                        0.24 * Responsive.getHeight(context),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                            )
                          : Image.asset(
                              'assets/sign_in/myco_logo.png',
                              height: 0.24 * Responsive.getHeight(context),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 16,
                          ),
                          child: Text(
                            company.companyName ?? 'My Company',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  18 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getColor(context).onInverseSurface,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.getColor(context).onSurfaceVariant.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                color: AppTheme.getColor(context).onSurface,
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final companyName = company.companyName ?? 'My Company';
                                final address = company.companyAddress ?? 'No address available';

                                final latitude = company.companyLatitude;
                                final longitude = company.companyLongitude;

                                final googleMapsLink = (latitude != null && longitude != null)
                                    ? 'https://maps.google.com/?q=$latitude,$longitude'
                                    : 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';

                                final shareText = '''
                                Company's Name : $companyName
                                
                                Address : $address
                                
                                $googleMapsLink
                                ''';

                                SharePlus.instance.share(
                                  ShareParams(text: shareText),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/visit_svgs/share.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),

                          ],
                        ),
                        Text(
                          company.companyAddress ?? 'No address available',
                          style: TextStyle(
                            color: AppTheme.getColor(context).onSurface,
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    child: Text(
                      "Company's Authorities",
                      style: TextStyle(
                        color: AppTheme.getColor(context).primary,
                        fontSize: 22 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (committee.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text('No authorities available.'),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: committee.length,
                      itemBuilder: (context, index) {
                        final authority = committee[index];
                        return AuthorityCard(authority: authority, context: context);
                      },
                    ),
                ],
              ),
            );
          }

          // Fallback in case of unexpected state
          return const SizedBox();
        },
      ),
    ),
  );
}
