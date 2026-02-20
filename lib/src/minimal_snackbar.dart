import 'package:flutter/material.dart';

/// Minimal top snackbar with rounded corners, left icon, and message.
/// Reusable across projects: copy this file and call [MinimalSnackbar.showSuccess],
/// [MinimalSnackbar.showFailure], or [MinimalSnackbar.showInfo].
///
/// Usage:
/// ```dart
/// AppSnackbar.showSuccess(context, 'Saved!');
/// AppSnackbar.showFailure(context, 'Something went wrong');
/// AppSnackbar.showInfo(context, 'Dyte meeting UI will be integrated here.');
/// ```
enum MinimalSnackbarType { success, failure, info }

class MinimalSnackbar {
  MinimalSnackbar._();

  static const double _horizontalMargin = 16;
  static const double _topMargin = 12;
  static const double _radius = 100;
  static const double _iconSize = 20;
  static const double _circleSize = 28;
  static const Duration _defaultDuration = Duration(seconds: 4);

  static const Color _successCircle = Color(0xFF10B981);
  static const Color _failureCircle = Color(0xFFDC2626);
  static const Color _infoCircle = Color(0xFFF59E0B);
  static const Color _background = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF1B1429);
  static const Color _iconColor = Color(0xFFFFFFFF);

  /// Shows a success snackbar at the top (white check in green circle).
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = _defaultDuration,
  }) {
    show(
      context,
      message,
      type: MinimalSnackbarType.success,
      duration: duration,
    );
  }

  /// Shows a failure snackbar at the top (white cross in red circle).
  static void showFailure(
    BuildContext context,
    String message, {
    Duration duration = _defaultDuration,
  }) {
    show(
      context,
      message,
      type: MinimalSnackbarType.failure,
      duration: duration,
    );
  }

  /// Shows an info snackbar at the top (white info icon in yellow circle).
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = _defaultDuration,
  }) {
    show(context, message, type: MinimalSnackbarType.info, duration: duration);
  }

  /// Shows a snackbar at the top with the given [type].
  static void show(
    BuildContext context,
    String message, {
    required MinimalSnackbarType type,
    Duration duration = _defaultDuration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _TopSnackbar(message: message, type: type),
    );
    overlay.insert(entry);
    Future.delayed(duration, entry.remove);
  }

  static Color _circleColor(MinimalSnackbarType type) {
    return switch (type) {
      MinimalSnackbarType.success => _successCircle,
      MinimalSnackbarType.failure => _failureCircle,
      MinimalSnackbarType.info => _infoCircle,
    };
  }

  static IconData _icon(MinimalSnackbarType type) {
    return switch (type) {
      MinimalSnackbarType.success => Icons.check,
      MinimalSnackbarType.failure => Icons.close,
      MinimalSnackbarType.info => Icons.info_outline,
    };
  }
}

class _TopSnackbar extends StatelessWidget {
  const _TopSnackbar({required this.message, required this.type});

  final String message;
  final MinimalSnackbarType type;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MinimalSnackbar._topMargin + MediaQuery.of(context).padding.top,
      left: MinimalSnackbar._horizontalMargin,
      right: MinimalSnackbar._horizontalMargin,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: MinimalSnackbar._background,
            borderRadius: BorderRadius.circular(MinimalSnackbar._radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: MinimalSnackbar._circleSize,
                height: MinimalSnackbar._circleSize,
                decoration: BoxDecoration(
                  color: MinimalSnackbar._circleColor(type),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MinimalSnackbar._icon(type),
                  size: MinimalSnackbar._iconSize,
                  color: MinimalSnackbar._iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: MinimalSnackbar._textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
