import 'package:flutter/material.dart';
import 'package:mobile_banking/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double height;

  const TextFieldContainer({
    super.key,
    this.child,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      width: size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
