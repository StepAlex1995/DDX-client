import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  TextInput({
    super.key,
    this.controller,
    this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.isPassword,
    this.onChange,
    this.maxLines,
    this.onlyPositiveNumbers,
  });

  final TextEditingController? controller;
  final IconData? icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  Function(String)? onChange;
  final int? maxLines;
  final bool? onlyPositiveNumbers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[600]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoTextField(
        inputFormatters: (onlyPositiveNumbers == true)
            ? [FilteringTextInputFormatter.allow(RegExp("[0-9]"))]
            : [],
        maxLines: maxLines ?? 1,
        onChanged: onChange,
        controller: controller,
        obscureText: isPassword,
        cursorColor: theme.primaryColor,
        placeholder: hint,
        placeholderStyle: theme.textTheme.labelSmall,
        padding: const EdgeInsets.symmetric(vertical: 12),
        prefix: Builder(
          builder: (context) {
            if(icon != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              );
            }
            return const SizedBox(width: 10,);
          }
        ),
        decoration: const BoxDecoration(),
        style: theme.textTheme.bodyMedium,
        keyboardType: inputType,
        textInputAction: inputAction,
      ),
    );
  }
}
