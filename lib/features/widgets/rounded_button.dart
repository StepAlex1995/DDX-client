import 'package:flutter/cupertino.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.bgrColor,
      this.textStyle,
      required this.text,
      this.onPressed});

  final String text;
  final Color bgrColor;
  final TextStyle? textStyle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgrColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: CupertinoButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
