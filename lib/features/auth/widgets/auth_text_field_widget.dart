import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';
import 'package:mock_mart/utils/text_styles.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isRequired;
  final int? maxLength;

  const AuthTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.isRequired = true,
    this.maxLength,
  });

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: interSemiBold
        ),
        Gaps.verticalGapOf(Dimensions.spacingSmall),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLength: widget.maxLength,
          style: interRegular.copyWith(
            fontSize: 14,
            color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: widget.maxLength != null ? '' : null,
            hintStyle: interRegular,
            prefixIcon: Icon(
              widget.icon,
              color: Theme.of(context).primaryColor,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Theme.of(context).extension<CustomThemeColors>()!.secondaryTextColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Theme.of(context).extension<CustomThemeColors>()!.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                color: Theme.of(context).extension<CustomThemeColors>()!.inactiveColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                color: Theme.of(context).extension<CustomThemeColors>()!.inactiveColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorStyle: interRegular
          ),
          validator: widget.isRequired ? widget.validator : null,
        ),
      ],
    );
  }
}