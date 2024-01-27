import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofma_app/theme/app_colors.dart';

class CustomDateTextInput extends StatefulWidget {
  const CustomDateTextInput(
      {super.key,
      required this.dateInput,
      required this.hintText,
      required this.icon});

  final TextEditingController dateInput;
  final String hintText;
  final IconData icon;

  @override
  State<CustomDateTextInput> createState() => _CustomDateTextInputState();
}

class _CustomDateTextInputState extends State<CustomDateTextInput> {
  @override
  void initState() {
    widget.dateInput.text = "";
    super.initState();
  }

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
      controller: widget.dateInput,
      style: textStyle,
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.secondaryColor,
          ),
          hintText: widget.hintText,
          hintStyle: hintTextStyle,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          errorStyle: TextStyle(color: Colors.red.shade200)),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

          setState(() {
            widget.dateInput.text = formattedDate;
          });
        }
      },
    );
  }
}
