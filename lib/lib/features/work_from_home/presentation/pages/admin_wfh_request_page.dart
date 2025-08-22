import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AdminWfhRequestPage extends StatefulWidget {
  const AdminWfhRequestPage({super.key});

  @override
  State<AdminWfhRequestPage> createState() => _AdminWfhRequestPageState();
}

class _AdminWfhRequestPageState extends State<AdminWfhRequestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return Scaffold(
      appBar: CustomAppbar(
        title: LanguageManager().get('wfh_request'),
        isKey: true,
      ),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            spacing: 15.0,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  border: Border(
                    top: BorderSide(color: AppTheme.getColor(context).primary),
                    bottom: BorderSide(
                      color: AppTheme.getColor(context).primary,
                    ),
                  ),
                ),
                child: CustomText(
                  DateTime.now().toLocal().toString(),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getColor(context).primary,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      VariableBag.screenHorizontalPadding *
                      Responsive.getResponsive(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NewTextField(
                        controller: controller,
                        // focusNode: focusNode,
                        onChange: (value) {
                          // Handle search logic here
                        },
                        hintText: LanguageManager().get('search'),
                        prefixIconPath: AppAssets.Search,
                      ),
                    ),
                    const SizedBox(width: 10),
                    BorderContainerWraper(
                      width: 40,
                      height: 40,
                      isShadow: true,
                      child: Icon(
                        Icons.filter_list,
                        color: AppTheme.getColor(context).onSecondary,
                      ),
                    ),

                    // InkWell(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(8.0),
                    //     decoration: BoxDecoration(
                    //       color: AppTheme.lightTheme(context).primaryColor,
                    //       borderRadius: BorderRadius.circular(5.0),
                    //     ),
                    //     child: Icon(
                    //       Icons.filter_list,
                    //       color: AppTheme.getColor(context).onSecondary,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
