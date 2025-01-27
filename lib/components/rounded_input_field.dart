import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_banking/constants.dart';
import 'package:mobile_banking/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const RoundedInputField({
    super.key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor1,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor1,
          ),
          hintText: hintText,
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}
