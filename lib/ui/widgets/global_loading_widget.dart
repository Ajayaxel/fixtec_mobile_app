import 'package:flutter/material.dart';
import 'package:fixteck/const/themes/app_themes.dart';

/// Global loading widget that matches the payment screen style
/// Dark teal spinner on white background
class GlobalLoadingWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? size;

  const GlobalLoadingWidget({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            indicatorColor ?? AppThemes.bgBtnColor,
          ),
          strokeWidth: size != null ? null : 3.0,
        ),
      ),
    );
  }
}

/// Small inline loading indicator for use in buttons or small spaces
class GlobalLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;

  const GlobalLoadingIndicator({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 16,
      height: size ?? 16,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppThemes.bgBtnColor,
        ),
      ),
    );
  }
}





