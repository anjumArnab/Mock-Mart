import 'package:flutter/material.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class OTPInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const OTPInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockWidth * .5,
      height: SizeConfig.blockWidth * .6,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: interBold.copyWith(
          fontSize: 24,
          color: AppTheme.getTextColor(context),
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppTheme.getCardColor(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            borderSide: BorderSide(
              color: AppTheme.getInactiveColor(context),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            borderSide: BorderSide(
              color: AppTheme.getInactiveColor(context),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            borderSide: BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}