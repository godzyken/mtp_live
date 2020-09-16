import 'package:flutter/material.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceSmall = SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium = SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceLarge = SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceSmall = SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium = SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge = SizedBox(width: _HorizontalSpaceLarge);

  static const Widget horizontalSpaceTiny = SizedBox(width: 5.0);

  static const Widget verticalSpaceTiny = SizedBox(height: 5.0);

  static const Widget verticalSpaceMassive = SizedBox(height: 120.0);

  static Widget spacedDivider = Column(
    children: const <Widget>[
      verticalSpaceMedium,
      const Divider(color: Colors.blueGrey, height: 5.0),
      verticalSpaceMedium,
    ],
  );

  static Widget verticalSpace(double height) => SizedBox(height: height);
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double screenHeightFraction(BuildContext context,
      {int dividedBy = 1, double offsetBy = 0}) =>
      (screenHeight(context) - offsetBy) / dividedBy;

  double screenWidthFraction(BuildContext context,
      {int dividedBy = 1, double offsetBy = 0}) =>
      (screenWidth(context) - offsetBy) / dividedBy;

  double halfScreenWidth(BuildContext context) =>
      screenWidthFraction(context, dividedBy: 2);

  double thirdScreenWidth(BuildContext context) =>
      screenWidthFraction(context, dividedBy: 3);
}