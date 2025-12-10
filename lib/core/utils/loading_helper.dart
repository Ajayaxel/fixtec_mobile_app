import 'package:flutter/material.dart';
import 'package:fixteck/const/themes/app_themes.dart';

/// Global helper class to show loading overlay easily
class LoadingHelper {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// Show loading overlay globally
  /// Uses the app's global loading style (dark teal spinner)
  static void show({
    required BuildContext context,
    String? message,
    Color? overlayColor,
    Color? indicatorColor,
    bool useWhiteBackground = false,
  }) {
    if (_isShowing) return;

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => _LoadingWidget(
        message: message,
        overlayColor: overlayColor,
        indicatorColor: indicatorColor,
        useWhiteBackground: useWhiteBackground,
      ),
    );

    overlay.insert(_overlayEntry!);
    _isShowing = true;
  }

  /// Hide loading overlay
  static void hide() {
    if (!_isShowing || _overlayEntry == null) return;

    _overlayEntry!.remove();
    _overlayEntry = null;
    _isShowing = false;
  }
}

class _LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? overlayColor;
  final Color? indicatorColor;
  final bool useWhiteBackground;

  const _LoadingWidget({
    this.message,
    this.overlayColor,
    this.indicatorColor,
    this.useWhiteBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = useWhiteBackground
        ? Colors.white
        : (overlayColor ?? Colors.black.withOpacity(0.5));
    final indicator = indicatorColor ?? AppThemes.bgBtnColor;

    return Material(
      color: Colors.transparent,
      child: Container(
        color: bgColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(indicator),
                strokeWidth: 3.0,
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: TextStyle(
                    color: useWhiteBackground ? Colors.black87 : indicator,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

