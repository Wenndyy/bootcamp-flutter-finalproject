import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconAsset;
  final Color textColor;
  final Color backgroundColor;
  final Color? outlineBorderColor;
  final VoidCallback onPressed;
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconAsset,
    required this.textColor,
    required this.backgroundColor,
    this.outlineBorderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(25),
              border: outlineBorderColor != null
                  ? Border.all(color: outlineBorderColor!, width: 1)
                  : null),
          child: Row(
            children: [
              Image.asset(
                iconAsset,
                height: 26,
                width: 26,
              ),
              const SizedBox(width: 24),
              Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
