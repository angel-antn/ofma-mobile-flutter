import 'package:flutter/material.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField(
      {super.key,
      required this.hintText,
      required this.icon,
      this.onChanged,
      this.validator});

  final String hintText;
  final IconData icon;
  final Function? onChanged;
  final Function? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.5,
        ));

    final errorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Colors.red.shade400,
          width: 1.5,
        ));

    const textStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.normal);

    const hintTextStyle =
        TextStyle(color: Colors.white60, fontWeight: FontWeight.normal);

    return TextFormField(
      obscureText: isObscure,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: textStyle,
      validator:
          widget.validator != null ? (value) => widget.validator!(value) : null,
      onChanged:
          widget.onChanged != null ? (value) => widget.onChanged!(value) : null,
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              icon: Icon(
                isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              )),
          hintText: widget.hintText,
          hintStyle: hintTextStyle,
          filled: true,
          fillColor: AppColors.translucentWhite,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          errorStyle: TextStyle(color: Colors.red.shade200)),
    );
  }
}
