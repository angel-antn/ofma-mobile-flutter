import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ofma_app/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.onSubmit,
    this.textEditingController,
    this.textInputType,
    this.textInputFormatter,
  });

  final String hintText;
  final IconData icon;
  final Function? onSubmit;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;

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

    return TextField(
      inputFormatters: textInputFormatter,
      keyboardType: textInputType,
      controller: textEditingController,
      autocorrect: false,
      style: textStyle,
      onSubmitted: onSubmit != null ? (value) => onSubmit!(value) : null,
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
