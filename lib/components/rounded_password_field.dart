import 'package:flutter/material.dart';
import 'package:mobile_banking/components/text_field_container.dart';
import 'package:mobile_banking/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int? maxLength;
  final String? Function(String?)? validator;

  const RoundedPasswordField({
    super.key,
    this.hintText,
    this.icon = Icons.lock,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.validator,
  });

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        maxLength: widget.maxLength,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            widget.icon,
            color: kPrimaryColor1,
          ),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor1,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
