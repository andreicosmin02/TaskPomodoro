import 'package:flutter/material.dart';

void showHint(
  BuildContext context,
  AnimationController? snackbarController,
  Animation<double>? snackbarOpacity,
  OverlayEntry? snackbarOverlayEntry,
  String message,
  Function(OverlayEntry) updateOverlayEntry,
) {
  snackbarController!.reset();

  if (snackbarOverlayEntry != null) {
    snackbarOverlayEntry.remove();
    snackbarOverlayEntry = null;
  }

  final OverlayEntry entry = _createSnackbarOverlayEntry(context, snackbarOpacity, message);
  Overlay.of(context).insert(entry);
  updateOverlayEntry(entry);

  Future.delayed(const Duration(seconds: 2), () {
    snackbarController.forward();
  });

  Future.delayed(const Duration(seconds: 3), () {
    snackbarOverlayEntry?.remove();
    snackbarOverlayEntry = null;
  });
}

OverlayEntry _createSnackbarOverlayEntry(
  BuildContext context,
  Animation<double>? snackbarOpacity,
  String message,
) {
  return OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: snackbarOpacity!,
        builder: (context, child) {
          return Opacity(
            opacity: snackbarOpacity.value,
            child: child,
          );
        },
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(221, 56, 56, 56),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}