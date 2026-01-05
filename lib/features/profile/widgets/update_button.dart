import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/utils/dimensions.dart';

class UpdateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isUpdating;

  const UpdateButton({
    super.key,
    required this.onPressed,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
        ),
        child: isUpdating
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'update_profile'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
