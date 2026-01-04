import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/profile/controllers/user_controller.dart';
import 'package:mock_mart/features/profile/widgets/custom_text_field.dart';
import 'package:mock_mart/features/profile/widgets/image_avatar.dart';
import 'package:mock_mart/features/profile/widgets/update_button.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';
import 'dart:io';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.getBackgroundColor(context),
        elevation: 0,
        title: Text(
          'profile'.tr,
          style: sectionTitleTextStyle.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: AppTheme.getTextColor(context),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userController.profileModel == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.getSecondaryTextColor(context),
                  ),
                  SizedBox(height: Dimensions.spacingDefault),
                  Text(
                    'failed_to_load_profile'.tr,
                    style: tabBarTextStyle.copyWith(
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                  ),
                  SizedBox(height: Dimensions.spacingDefault),
                  ElevatedButton(
                    onPressed: () => userController.getUserData(),
                    child: Text('retry'.tr),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => userController.getUserData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    _buildProfileHeader(context, userController),
                    SizedBox(height: Dimensions.spacingLarge),
                    _buildProfileInfo(context, userController),
                    SizedBox(height: Dimensions.spacingLarge),
                    ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  "logout".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Get.find<UserController>().logOut();
                },
              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    UserController userController,
  ) {
    final profile = userController.profileModel!;

    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: Dimensions.avatarSizeLarge,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                backgroundImage:
                    profile.image != null && profile.image!.isNotEmpty
                    ? NetworkImage(profile.image!)
                    : null,
                child: profile.image == null || profile.image!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: Dimensions.iconSizeLarge,
                        color: AppTheme.primaryColor,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _showEditProfileDialog(context, userController);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.getBackgroundColor(context),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: Dimensions.iconSizeSmall,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.spacingDefault),
          Text(
            profile.fullName,
            style: userNameTextStyle.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: AppTheme.getTextColor(context),
            ),
          ),
          SizedBox(height: Dimensions.spacingExtraSmall),
          Text(
            profile.email ?? '',
            style: tabBarTextStyle.copyWith(
              color: AppTheme.getSecondaryTextColor(context),
            ),
          ),
          if (profile.phone != null && profile.phone!.isNotEmpty) ...[
            SizedBox(height: Dimensions.spacingExtraSmall),
            Text(
              profile.phone!,
              style: tabBarTextStyle.copyWith(
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileInfo(
    BuildContext context,
    UserController userController,
  ) {
    final profile = userController.profileModel!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            'member_since'.tr,
            _formatDate(profile.createdAt),
            Icons.calendar_today,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Icon(
            icon,
            size: Dimensions.iconSizeDefault,
            color: AppTheme.primaryColor,
          ),
          SizedBox(width: Dimensions.spacingDefault),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tabBarTextStyle.copyWith(
                    color: AppTheme.getSecondaryTextColor(context),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: tabBarTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final DateTime dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  void _showEditProfileDialog(
    BuildContext context,
    UserController userController,
  ) {
    final profile = userController.profileModel!;
    final fNameController = TextEditingController(text: profile.fName);
    final lNameController = TextEditingController(text: profile.lName);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GetBuilder<UserController>(
        builder: (controller) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: AppTheme.getBackgroundColor(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radiusLarge),
              topRight: Radius.circular(Dimensions.radiusLarge),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.getSecondaryTextColor(context),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.spacingDefault),
                Text(
                  'edit_profile'.tr,
                  style: sectionTitleTextStyle.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                SizedBox(height: Dimensions.spacingLarge),

                // Profile Image Picker
                Center(
                  child: ImageAvatar(
                    localImage: controller.pickedFile != null
                        ? File(controller.pickedFile!.path)
                        : null,
                    networkImage: profile.image,
                    onTap: controller.pickImage,
                  ),
                ),

                if (controller.pickedFile != null)
                  Center(
                    child: TextButton.icon(
                      onPressed: () => controller.removeImage(),
                      icon: Icon(Icons.delete_outline, size: 16),
                      label: Text('remove_image'.tr),
                    ),
                  ),

                SizedBox(height: Dimensions.spacingLarge),
                CustomTextField(
                  controller: fNameController,
                  labelText: "first_name".tr,
                ),
                SizedBox(height: Dimensions.spacingDefault),

                CustomTextField(
                  controller: lNameController,
                  labelText: "last_name".tr,
                ),
                SizedBox(height: Dimensions.spacingDefault),

                CustomTextField(
                  controller: emailController,
                  labelText: "email".tr,
                ),
                SizedBox(height: Dimensions.spacingDefault),
                CustomTextField(
                  controller: phoneController,
                  labelText: "phone".tr,
                ),
                SizedBox(height: Dimensions.spacingLarge),

                UpdateButton(
                  onPressed: () => controller.updateProfile(
                    fName: fNameController.text,
                    lName: lNameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  ),
                  isUpdating: controller.isUpdating,
                ),
                SizedBox(height: Dimensions.spacingDefault),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
