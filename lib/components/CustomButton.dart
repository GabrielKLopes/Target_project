import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final double width;
  final double height;
  final Color textColor;


  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color = Colors.blue,
    this.width = double.infinity,
    this.height = 50.0,
    this.textColor = Colors.white,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor,
          fontFamily: 'Roboto',
          fontSize: 15),
        ),
      ),
    );
  }
}
