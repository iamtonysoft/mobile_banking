import 'package:flutter/material.dart';
import 'package:mobile_banking/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor1,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            backgroundColor: color,
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
