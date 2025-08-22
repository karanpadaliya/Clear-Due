import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_event.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_state.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class LostAndFoundItemDetailsScreen extends StatelessWidget {
  final LostFoundEntity item;

  const LostAndFoundItemDetailsScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final preferenceManager = GetIt.I<PreferenceManager>();

      final companyId = await preferenceManager.getCompanyId();
      final userId = await preferenceManager.getUserId();
      final languageId = await preferenceManager.getLanguageId();

      final request = {
        'getListNew': 'getListNew',
        'society_id': companyId,
        'user_id': userId,
        'language_id': languageId,
        'lost_found_master_id': item.lostFoundMasterId,
        'is_details_view': '1',
      };

      context.read<LostAndFoundBloc>().add(GetLostAndFoundItemsEvent(request));
    });

    return BlocBuilder<LostAndFoundBloc, LostAndFoundState>(
      builder: (context, state) {
        if (state is LostAndFoundLoading) {
          return const CustomLoader();
        } else if (state is LostAndFoundLoaded) {
          final data = state.items.first;

          final showEdit =
              data.userId != null &&
              data.userId == state.userId &&
              data.isUser == true;

          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                item.lostFoundType?.toLowerCase() == 'found'
                    ? LanguageManager().get('Item_found')
                    : LanguageManager().get('Item_lost'),
                style: TextStyle(
                  fontFamily: 'Gilroy-Bold',
                  fontSize: 18 * Responsive.getResponsive(context),
                  fontWeight: FontWeight.w400,
                  color: AppTheme.getColor(context).onSurfaceVariant,
                ),
              ),
              centerTitle: false,
              actions: [
                if (showEdit)
                  Container(
                    margin: EdgeInsets.only(
                      right: 20.0 * Responsive.getResponsive(context),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                          'LostAndFoundFragmentAddScreen',
                          extra: data,
                        );
                      },
                      child: CustomText(
                        'Edit',
                        fontSize: 18 * Responsive.getResponsive(context),
                        color: AppTheme.getColor(context).primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            body: _buildLoadedContent(
              context,
              data,
              state.userId,
              state.menuChat,
            ),
          );
        } else if (state is LostAndFoundError) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Center(child: Text(state.message)),
          );
        } else if (state is LostAndFoundItemDeletedSuccess) {
          Fluttertoast.showToast(msg: state.response.message ?? '');
          context.pop('refresh');
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    LostFoundEntity data,
    String userId,
    bool menuChat,
  ) {
    bool showDelete = false;
    bool showChat = false;

    if (data.userId != null && data.userId == userId && data.isUser == true) {
      showDelete = true;
      showChat = false;
    } else {
      showDelete = false;

      if (!menuChat) {
        if (GetIt.I<PreferenceManager>().getUserType() == '1' &&
            data.userType == '0') {
          if (data.tenantView == '1') {
            showChat = false;
          } else {
            showChat = true;
          }
        } else {
          showChat = true;
        }
      } else {
        showChat = false;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * Responsive.getResponsive(context),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _imagePreview(context, data.lostFoundImage),
            const SizedBox(height: 16),
            _itemDetails(context, data),
            const SizedBox(height: 24),
            _buildHeader(context, 'Contact Details'),
            _readOnlyField(
              context,
              'Name',
              data.userFullName ?? '',
              'assets/lost_and_found/profile-circle.png',
            ),
            const SizedBox(height: 16),
            _readOnlyField(
              context,
              'Phone',
              _getPhoneNumber(data),
              'assets/lost_and_found/phone.png',
            ),
            const SizedBox(height: 16),
            _readOnlyField(
              context,
              'Branch',
              data.branchName ?? '',
              'assets/lost_and_found/data.png',
            ),
            const SizedBox(height: 16),
            _readOnlyField(
              context,
              'Department',
              data.departmentName ?? '',
              'assets/lost_and_found/note-favorite.png',
            ),
            SizedBox(height: 0.03 * Responsive.getHeight(context)),

            if (showDelete)
              Padding(
                padding: EdgeInsets.all(
                  8.0 * Responsive.getResponsive(context),
                ),
                child: MyCoButton(
                  onTap: () async {
                    final blocContext = context;

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: CustomAlertDialog(
                          alertType: AlertType.delete,
                          content: LanguageManager().get('sure_to_delete'),
                          cancelText: LanguageManager().get('cancel'),
                          confirmText: LanguageManager().get('delete'),
                          onConfirm: () async {
                            final preferenceManager =
                                GetIt.I<PreferenceManager>();

                            final companyId = await preferenceManager
                                .getCompanyId();
                            final userId = await preferenceManager.getUserId();
                            final languageId = await preferenceManager
                                .getLanguageId();

                            final request = {
                              'deleteLostFound': 'deleteLostFound',
                              'society_id': companyId,
                              'user_id': userId,
                              'language_id': languageId,
                              'lost_found_master_id': item.lostFoundMasterId,
                            };

                            blocContext.read<LostAndFoundBloc>().add(
                              DeleteLostAndFoundItemsEvent(request),
                            );
                            Navigator.of(blocContext).pop();
                          },
                          onCancel: () {
                            Navigator.of(blocContext).pop();
                          },
                        ),
                      ),
                    );
                  },
                  title: 'DELETE',
                  height: 0.05 * Responsive.getHeight(context),
                  isShadowBottomLeft: true,
                  boarderRadius: 50,
                  fontFamily: 'Gilroy-Bold',
                  fontWeight: FontWeight.w500,
                ),
              ),

            if (showChat)
              Padding(
                padding: EdgeInsets.all(
                  8.0 * Responsive.getResponsive(context),
                ),
                child: MyCoButton(
                  onTap: () {
                    final Map<String, String?> request;
                    if (item.isUser == true) {
                      request = {
                        'userType': 'Resident',
                        'userId': item.userId,
                        'userProfile': item.userProfilePic,
                        'userName': item.userFullName,
                        'from': '1',
                        'sentTo': '0',
                        'block_name': item.blockName,
                        'recidentMobile': item.userMobile,
                        'publicMobile': item.publicMobile,
                      };
                    } else {
                      request = {
                        'userType': 'gaurd',
                        'userId': item.userId,
                        'userProfile': item.userProfilePic,
                        'userName': item.userFullName,
                        'block_name': 'Gatekeeper',
                        'sentTo': '1',
                        'recidentMobile': item.userMobile,
                        'publicMobile': '1',
                      };
                    }
                    context.pushNamed(
                      RoutePaths.lostAndFoundChatScreen,
                      extra: request,
                    );
                  },
                  title: 'CHAT',
                  height: 0.05 * Responsive.getHeight(context),
                  isShadowBottomLeft: true,
                  boarderRadius: 50,
                  fontFamily: 'Gilroy-Bold',
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getPhoneNumber(LostFoundEntity values) {
    final publicMobile = values.publicMobile;
    final userId = values.userId;
    final currentUserId = GetIt.I<PreferenceManager>().getUserId();
    final privatePlaceholder = LanguageManager().get('private');

    if (publicMobile != null && publicMobile.toLowerCase() == '0') {
      return values.userMobile ?? '';
    } else {
      if (userId != null && userId == currentUserId) {
        return values.userMobile ?? '';
      } else {
        return privatePlaceholder;
      }
    }
  }

  Widget _imagePreview(BuildContext context, String? imageUrl) => Container(
    height: 0.18 * Responsive.getHeight(context),
    decoration: BoxDecoration(
      color: const Color(0xFFEEF7FD),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF2F648E)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: (imageUrl != null && imageUrl.isNotEmpty)
          ? Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity)
          : const Center(child: Text('No Image')),
    ),
  );

  Widget _itemDetails(BuildContext context, LostFoundEntity? values) =>
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2F648E)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(context, 'Item Name'),
            const SizedBox(height: 4),
            NewTextField(
              controller: TextEditingController(
                text: values?.lostFoundTitle ?? '',
              ),
              prefix: _prefixIcon('assets/lost_and_found/item-name.png'),
            ),
            const SizedBox(height: 12),
            _buildLabel(context, 'Description'),
            const SizedBox(height: 4),
            NewTextField(
              controller: TextEditingController(
                text: values?.lostFoundDescription ?? '',
              ),

              prefix: _prefixIcon('assets/lost_and_found/message-edit.png'),
            ),
          ],
        ),
      );

  Widget _readOnlyField(
    BuildContext context,
    String label,
    String value,
    String iconPath,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel(context, label),
      const SizedBox(height: 4),
      NewTextField(
        controller: TextEditingController(text: value),

        prefix: _prefixIcon(iconPath),
      ),
    ],
  );

  TextStyle _hintStyle() => const TextStyle(
    fontFamily: 'Gilroy-SemiBold',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.black54,
  );

  TextStyle _typingStyle(BuildContext context) => TextStyle(
    fontFamily: 'Gilroy-SemiBold',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppTheme.getColor(context).onSurfaceVariant,
  );

  EdgeInsets _contentPadding(BuildContext context) =>
      EdgeInsets.symmetric(vertical: 14 * Responsive.getResponsive(context));

  Widget _prefixIcon(String assetPath) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Image.asset(assetPath, width: 20, height: 20, fit: BoxFit.contain),
  );

  Widget _buildLabel(BuildContext context, String label) => CustomText(
    label,
    fontSize: 12 * Responsive.getResponsive(context),
    fontWeight: FontWeight.w700,
    color: AppTheme.getColor(context).onSurface,
  );

  Widget _buildHeader(BuildContext context, String header) => Padding(
    padding: EdgeInsets.only(bottom: 0.01 * Responsive.getHeight(context)),
    child: CustomText(
      header,
      color: AppTheme.getColor(context).onSurface,
      fontSize: 18 * Responsive.getResponsive(context),
      fontWeight: FontWeight.w700,
    ),
  );
}
