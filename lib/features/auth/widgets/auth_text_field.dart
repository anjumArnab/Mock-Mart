import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/text_styles.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isRequired;
  final int? maxLength;

  const AuthTextField({
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
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: interSemiBold.copyWith(
            fontSize: 14,
            color: AppTheme.getTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLength: widget.maxLength,
          style: interRegular.copyWith(
            fontSize: 14,
            color: AppTheme.getTextColor(context),
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: widget.maxLength != null ? '' : null,
            hintStyle: interRegular.copyWith(
              fontSize: 14,
              color: AppTheme.getSecondaryTextColor(context),
            ),
            prefixIcon: Icon(
              widget.icon,
              color: AppTheme.primaryColor,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: AppTheme.getCardColor(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.getInactiveColor(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.getInactiveColor(context),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorStyle: interRegular.copyWith(
              fontSize: 12,
              color: AppTheme.red,
            ),
          ),
          validator: widget.isRequired ? widget.validator : null,
        ),
      ],
    );
  }
}