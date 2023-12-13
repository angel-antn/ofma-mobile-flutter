import 'package:flutter/material.dart';
import 'package:ofma_app/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.validator,
    this.initialValue,
  });

  final String hintText;
  final IconData icon;
  final Function? onChanged;
  final Function? validator;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
          width: 1.5,
        ));

    final errorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Colors.red.shade400,
          width: 1.5,
        ));

    const textStyle = TextStyle(fontWeight: FontWeight.normal);

    final hintTextStyle = TextStyle(
        color: AppColors.secondaryColor, fontWeight: FontWeight.normal);

    return TextFormField(
      initialValue: initialValue,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textStyle,
      validator: validator != null ? (value) => validator!(value) : null,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColors.secondaryColor,
          ),
          hintText: hintText,
          hintStyle: hintTextStyle,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          errorStyle: TextStyle(color: Colors.red.shade200)),
    );
  }
}
