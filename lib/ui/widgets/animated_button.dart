import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;

  const AnimatedButton(
      {Key key,
      this.initialText,
      this.finalText,
      this.buttonStyle,
      this.iconData,
      this.iconSize,
      this.animationDuration})
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
          color: widget.buttonStyle.primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                widget.iconData,
                size: widget.iconSize,
                color: widget.buttonStyle.primaryColor,
              ),
              Text(
                widget.initialText,
                style: widget.buttonStyle.initialTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation;

  ButtonStyle(
      {this.initialTextStyle,
      this.finalTextStyle,
      this.primaryColor,
      this.secondaryColor,
      this.elevation});
}

enum ButtonState {
  SHOW_ONLY_TEXT,
  SHOW_ONLY_ICON,
  SHOW_TEXT_ICON,
}
