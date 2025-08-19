import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CDTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool enabled;
  final String? errorText;
  final VoidCallback? onEditingComplete;
  final int? maxLength; // New optional maxLength property

  const CDTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.enabled = true,
    this.errorText,
    this.onEditingComplete,
    this.maxLength,
  });

  @override
  State<CDTextField> createState() => _CDTextFieldState();
}

class _CDTextFieldState extends State<CDTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      _obscureText = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      maxLength: widget.maxLength,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textDark,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        counterText: '',
        // Hides the maxLength counter text
        prefixIcon: Icon(widget.icon, color: AppColors.primary),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.grey, fontSize: 15),
        errorText: widget.errorText,
        filled: true,
        fillColor: AppColors.lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.statusFailed),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}
